import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:chatbox_flutter/features/knowledge_base/data/embedding_service.dart';

void main() {
  group('EmbeddingModelConfig', () {
    test('should create config with required fields', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-key',
        dimensions: 1536,
      );

      expect(config.providerId, equals('openai'));
      expect(config.model, equals('text-embedding-3-small'));
      expect(config.baseUrl, equals('https://api.openai.com/v1'));
      expect(config.apiKey, equals('test-key'));
      expect(config.dimensions, equals(1536));
    });

    test('should have correct default OpenAI config', () {
      const config = EmbeddingModelConfig.defaultOpenAI;

      expect(config.providerId, equals('openai'));
      expect(config.model, equals('text-embedding-3-small'));
      expect(config.baseUrl, equals('https://api.openai.com/v1'));
      expect(config.dimensions, equals(1536));
      expect(config.apiKey, isEmpty);
    });

    test('should have correct default OpenAI Large config', () {
      const config = EmbeddingModelConfig.defaultOpenAILarge;

      expect(config.providerId, equals('openai'));
      expect(config.model, equals('text-embedding-3-large'));
      expect(config.dimensions, equals(3072));
    });

    test('should support copyWith', () {
      const original = EmbeddingModelConfig.defaultOpenAI;
      final modified = original.copyWith(
        apiKey: 'new-key',
        dimensions: 512,
      );

      expect(modified.apiKey, equals('new-key'));
      expect(modified.dimensions, equals(512));
      expect(modified.model, equals(original.model)); // unchanged
      expect(modified.baseUrl, equals(original.baseUrl)); // unchanged
    });

    test('copyWith should preserve unchanged fields', () {
      const original = EmbeddingModelConfig(
        providerId: 'custom',
        model: 'custom-model',
        baseUrl: 'https://custom.api.com',
        apiKey: 'custom-key',
        dimensions: 768,
      );

      final modified = original.copyWith(model: 'new-model');

      expect(modified.providerId, equals('custom'));
      expect(modified.model, equals('new-model'));
      expect(modified.baseUrl, equals('https://custom.api.com'));
      expect(modified.apiKey, equals('custom-key'));
      expect(modified.dimensions, equals(768));
    });
  });

  group('EmbeddingService', () {
    late EmbeddingService embeddingService;

    setUp(() {
      embeddingService = EmbeddingService();
    });

    test('should not be configured by default', () {
      expect(embeddingService.isConfigured, isFalse);
      expect(embeddingService.config, isNull);
    });

    test('should be configured after configure() call', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-api-key',
        dimensions: 1536,
      );

      embeddingService.configure(config);

      expect(embeddingService.isConfigured, isTrue);
      expect(embeddingService.config, isNotNull);
      expect(embeddingService.config!.apiKey, equals('test-api-key'));
    });

    test('should not be configured with empty API key', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: '',
        dimensions: 1536,
      );

      embeddingService.configure(config);

      expect(embeddingService.isConfigured, isFalse);
    });

    test('should throw when embed() called without configuration', () {
      expect(
        () => embeddingService.embed('test text'),
        throwsException,
      );
    });

    test('should throw when embedBatch() called without configuration', () {
      expect(
        () => embeddingService.embedBatch(['text1', 'text2']),
        throwsException,
      );
    });

    test('embedBatch should return empty list for empty input', () async {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-api-key',
        dimensions: 1536,
      );

      embeddingService.configure(config);

      final results = await embeddingService.embedBatch([]);
      expect(results, isEmpty);
    });
  });

  group('EmbeddingService API Response Parsing', () {
    test('should parse single embedding response', () {
      final responseData = {
        'data': [
          {
            'embedding': [0.1, 0.2, 0.3, 0.4, 0.5],
            'index': 0,
          }
        ],
        'model': 'text-embedding-3-small',
        'usage': {'prompt_tokens': 5, 'total_tokens': 5},
      };

      final embeddings = responseData['data'] as List;
      final embedding = embeddings[0]['embedding'] as List;
      final result = embedding.map((e) => (e as num).toDouble()).toList();

      expect(result.length, equals(5));
      expect(result[0], equals(0.1));
      expect(result[4], equals(0.5));
    });

    test('should parse batch embedding response with correct ordering', () {
      final responseData = {
        'data': [
          {'embedding': [0.1, 0.2], 'index': 1}, // out of order
          {'embedding': [0.5, 0.6], 'index': 2},
          {'embedding': [0.3, 0.4], 'index': 0},
        ],
        'model': 'text-embedding-3-small',
      };

      final embeddings = responseData['data'] as List;
      embeddings.sort((a, b) => (a['index'] as int).compareTo(b['index'] as int));

      final results = <List<double>>[];
      for (final item in embeddings) {
        final embedding = item['embedding'] as List;
        results.add(embedding.map((e) => (e as num).toDouble()).toList());
      }

      expect(results.length, equals(3));
      expect(results[0], equals([0.3, 0.4])); // index 0
      expect(results[1], equals([0.1, 0.2])); // index 1
      expect(results[2], equals([0.5, 0.6])); // index 2
    });

    test('should handle response with integer embeddings', () {
      final responseData = {
        'data': [
          {'embedding': [1, 2, 3, 4, 5], 'index': 0},
        ],
      };

      final embeddings = responseData['data'] as List;
      final embedding = embeddings[0]['embedding'] as List;
      final result = embedding.map((e) => (e as num).toDouble()).toList();

      expect(result, equals([1.0, 2.0, 3.0, 4.0, 5.0]));
    });
  });

  group('Embedding Dimensions', () {
    test('OpenAI text-embedding-3-small should have 1536 dimensions', () {
      expect(EmbeddingModelConfig.defaultOpenAI.dimensions, equals(1536));
    });

    test('OpenAI text-embedding-3-large should have 3072 dimensions', () {
      expect(EmbeddingModelConfig.defaultOpenAILarge.dimensions, equals(3072));
    });

    test('should support custom dimensions', () {
      const config = EmbeddingModelConfig(
        providerId: 'custom',
        model: 'custom-model',
        baseUrl: 'https://api.example.com',
        apiKey: 'key',
        dimensions: 768, // BERT-like dimensions
      );

      expect(config.dimensions, equals(768));
    });

    test('should allow dimension reduction', () {
      final original = EmbeddingModelConfig.defaultOpenAI;
      final reduced = original.copyWith(dimensions: 256);

      expect(reduced.dimensions, equals(256));
      expect(reduced.dimensions, lessThan(original.dimensions));
    });
  });

  group('API Request Construction', () {
    test('should construct correct request body for embed', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-key',
        dimensions: 1536,
      );

      final requestBody = jsonEncode({
        'model': config.model,
        'input': 'Test text to embed',
        'dimensions': config.dimensions,
      });

      final decoded = jsonDecode(requestBody);
      expect(decoded['model'], equals('text-embedding-3-small'));
      expect(decoded['input'], equals('Test text to embed'));
      expect(decoded['dimensions'], equals(1536));
    });

    test('should construct correct request body for embedBatch', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-key',
        dimensions: 1536,
      );

      final texts = ['First text', 'Second text', 'Third text'];
      final requestBody = jsonEncode({
        'model': config.model,
        'input': texts,
        'dimensions': config.dimensions,
      });

      final decoded = jsonDecode(requestBody);
      expect(decoded['model'], equals('text-embedding-3-small'));
      expect(decoded['input'], equals(texts));
      expect(decoded['dimensions'], equals(1536));
    });

    test('should use correct endpoint URL', () {
      const config = EmbeddingModelConfig(
        providerId: 'openai',
        model: 'text-embedding-3-small',
        baseUrl: 'https://api.openai.com/v1',
        apiKey: 'test-key',
        dimensions: 1536,
      );

      final endpoint = '${config.baseUrl}/embeddings';
      expect(endpoint, equals('https://api.openai.com/v1/embeddings'));
    });

    test('should handle custom base URLs', () {
      const config = EmbeddingModelConfig(
        providerId: 'azure',
        model: 'text-embedding-ada-002',
        baseUrl: 'https://myresource.openai.azure.com/openai/deployments/embedding',
        apiKey: 'test-key',
        dimensions: 1536,
      );

      final endpoint = '${config.baseUrl}/embeddings';
      expect(
        endpoint,
        equals('https://myresource.openai.azure.com/openai/deployments/embedding/embeddings'),
      );
    });
  });

  group('Batch Processing', () {
    test('should handle batch size of 100', () {
      const batchSize = 100;
      final texts = List.generate(250, (i) => 'Text $i');

      final batches = <List<String>>[];
      for (var i = 0; i < texts.length; i += batchSize) {
        final end = (i + batchSize > texts.length) ? texts.length : i + batchSize;
        batches.add(texts.sublist(i, end));
      }

      expect(batches.length, equals(3));
      expect(batches[0].length, equals(100));
      expect(batches[1].length, equals(100));
      expect(batches[2].length, equals(50));
    });

    test('should handle single batch when texts < batchSize', () {
      const batchSize = 100;
      final texts = List.generate(50, (i) => 'Text $i');

      final batches = <List<String>>[];
      for (var i = 0; i < texts.length; i += batchSize) {
        final end = (i + batchSize > texts.length) ? texts.length : i + batchSize;
        batches.add(texts.sublist(i, end));
      }

      expect(batches.length, equals(1));
      expect(batches[0].length, equals(50));
    });
  });
}
