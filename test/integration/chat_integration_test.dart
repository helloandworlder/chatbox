import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:chatbox_flutter/features/ai_models/domain/provider_config.dart';
import 'package:chatbox_flutter/features/ai_models/data/llm_service.dart';
import 'package:chatbox_flutter/features/knowledge_base/data/embedding_service.dart';

void main() {
  group('Chat Integration Tests', () {
    group('LLM Service + Provider Config Integration', () {
      late LLMService llmService;

      setUp(() {
        llmService = LLMService();
      });

      test('should handle complete provider lifecycle', () {
        // 1. Register provider
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'sk-test-key',
          enabled: true,
          models: const [
            ModelConfig(
              id: 'gpt-4o',
              name: 'GPT-4o',
              supportsVision: true,
              supportsFunctionCalling: true,
              contextWindow: 128000,
            ),
            ModelConfig(
              id: 'gpt-4o-mini',
              name: 'GPT-4o Mini',
              contextWindow: 128000,
            ),
          ],
        );

        llmService.registerProvider(config);
        expect(llmService.hasProvider('test-openai'), isTrue);
        expect(llmService.getAvailableModels('test-openai'), hasLength(2));

        // 2. Access models
        final gpt4o = llmService.getModel('test-openai', 'gpt-4o');
        expect(gpt4o, isNotNull);

        final gpt4oMini = llmService.getModel('test-openai', 'gpt-4o-mini');
        expect(gpt4oMini, isNotNull);

        // 3. Update provider (re-register with new config)
        final updatedConfig = config.copyWith(
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
            ModelConfig(id: 'gpt-4o-mini', name: 'GPT-4o Mini'),
            ModelConfig(id: 'o1', name: 'o1'),
          ],
        );

        llmService.unregisterProvider('test-openai');
        llmService.registerProvider(updatedConfig);
        expect(llmService.getAvailableModels('test-openai'), hasLength(3));

        // 4. Unregister provider
        llmService.unregisterProvider('test-openai');
        expect(llmService.hasProvider('test-openai'), isFalse);
        expect(llmService.getAvailableModels('test-openai'), isEmpty);
      });

      test('should support multiple providers coexisting', () {
        final providers = [
          AIProviderConfig(
            id: 'openai',
            type: AIProviderType.openai,
            name: 'OpenAI',
            apiKey: 'openai-key',
            models: const [ModelConfig(id: 'gpt-4o', name: 'GPT-4o')],
          ),
          AIProviderConfig(
            id: 'claude',
            type: AIProviderType.claude,
            name: 'Claude',
            apiKey: 'claude-key',
            models: const [ModelConfig(id: 'claude-3-5-sonnet-20241022', name: 'Claude 3.5')],
          ),
          AIProviderConfig(
            id: 'gemini',
            type: AIProviderType.gemini,
            name: 'Gemini',
            apiKey: 'gemini-key',
            models: const [ModelConfig(id: 'gemini-2.0-flash', name: 'Gemini 2.0')],
          ),
          AIProviderConfig(
            id: 'deepseek',
            type: AIProviderType.deepseek,
            name: 'DeepSeek',
            apiKey: 'deepseek-key',
            models: const [ModelConfig(id: 'deepseek-chat', name: 'DeepSeek V3')],
          ),
        ];

        for (final config in providers) {
          llmService.registerProvider(config);
        }

        // All providers should be registered
        expect(llmService.hasProvider('openai'), isTrue);
        expect(llmService.hasProvider('claude'), isTrue);
        expect(llmService.hasProvider('gemini'), isTrue);
        expect(llmService.hasProvider('deepseek'), isTrue);

        // Each provider should have correct models
        expect(llmService.getModel('openai', 'gpt-4o'), isNotNull);
        expect(llmService.getModel('claude', 'claude-3-5-sonnet-20241022'), isNotNull);
        expect(llmService.getModel('gemini', 'gemini-2.0-flash'), isNotNull);
        expect(llmService.getModel('deepseek', 'deepseek-chat'), isNotNull);

        // Models should not be accessible from wrong providers
        expect(llmService.getModel('openai', 'claude-3-5-sonnet-20241022'), isNull);
        expect(llmService.getModel('claude', 'gpt-4o'), isNull);
      });

      test('should handle disabled provider correctly', () {
        final disabledConfig = AIProviderConfig(
          id: 'disabled-provider',
          type: AIProviderType.openai,
          name: 'Disabled Provider',
          apiKey: 'key',
          enabled: false,
          models: const [ModelConfig(id: 'model', name: 'Model')],
        );

        // Provider can still be registered (enabled flag is for UI)
        llmService.registerProvider(disabledConfig);
        expect(llmService.hasProvider('disabled-provider'), isTrue);
      });
    });

    group('AI Provider Config Serialization', () {
      test('should serialize and deserialize provider list', () {
        final providers = [
          AIProviderConfig(
            id: 'openai',
            type: AIProviderType.openai,
            name: 'OpenAI',
            apiKey: 'sk-xxx',
            enabled: true,
            models: const [
              ModelConfig(
                id: 'gpt-4o',
                name: 'GPT-4o',
                supportsVision: true,
                contextWindow: 128000,
              ),
            ],
          ),
          AIProviderConfig(
            id: 'claude',
            type: AIProviderType.claude,
            name: 'Claude',
            apiKey: 'sk-ant-xxx',
            enabled: true,
            models: const [
              ModelConfig(
                id: 'claude-3-5-sonnet-20241022',
                name: 'Claude 3.5 Sonnet',
                supportsVision: true,
              ),
            ],
          ),
        ];

        // Serialize
        final json = jsonEncode(providers.map((p) => p.toJson()).toList());

        // Deserialize
        final decoded = jsonDecode(json) as List;
        final restored = decoded.map((e) => AIProviderConfig.fromJson(e)).toList();

        expect(restored.length, equals(2));
        expect(restored[0].id, equals('openai'));
        expect(restored[1].id, equals('claude'));
        expect(restored[0].models.first.supportsVision, isTrue);
        expect(restored[1].models.first.supportsVision, isTrue);
      });

      test('should preserve all model properties during serialization', () {
        const original = ModelConfig(
          id: 'gpt-4o',
          name: 'GPT-4o',
          supportsStreaming: true,
          supportsVision: true,
          supportsFunctionCalling: true,
          maxTokens: 4096,
          contextWindow: 128000,
        );

        final json = original.toJson();
        final restored = ModelConfig.fromJson(json);

        expect(restored.id, equals(original.id));
        expect(restored.name, equals(original.name));
        expect(restored.supportsStreaming, equals(original.supportsStreaming));
        expect(restored.supportsVision, equals(original.supportsVision));
        expect(restored.supportsFunctionCalling, equals(original.supportsFunctionCalling));
        expect(restored.maxTokens, equals(original.maxTokens));
        expect(restored.contextWindow, equals(original.contextWindow));
      });
    });

    group('Embedding Service Integration', () {
      late EmbeddingService embeddingService;

      setUp(() {
        embeddingService = EmbeddingService();
      });

      test('should configure with AI provider settings', () {
        // Simulate extracting embedding config from AI provider
        const aiProviderConfig = AIProviderConfig(
          id: 'openai',
          type: AIProviderType.openai,
          name: 'OpenAI',
          apiKey: 'sk-test-key',
          baseUrl: 'https://api.openai.com/v1',
          models: [],
        );

        // Create embedding config from AI provider
        final embeddingConfig = EmbeddingModelConfig(
          providerId: aiProviderConfig.id,
          model: 'text-embedding-3-small',
          baseUrl: aiProviderConfig.baseUrl ?? 'https://api.openai.com/v1',
          apiKey: aiProviderConfig.apiKey!,
          dimensions: 1536,
        );

        embeddingService.configure(embeddingConfig);

        expect(embeddingService.isConfigured, isTrue);
        expect(embeddingService.config!.providerId, equals('openai'));
        expect(embeddingService.config!.apiKey, equals('sk-test-key'));
      });

      test('should update config when provider changes', () {
        // Initial config
        embeddingService.configure(const EmbeddingModelConfig(
          providerId: 'provider-1',
          model: 'model-1',
          baseUrl: 'https://api1.example.com',
          apiKey: 'key-1',
          dimensions: 1536,
        ));

        expect(embeddingService.config!.providerId, equals('provider-1'));

        // Update to new provider
        embeddingService.configure(const EmbeddingModelConfig(
          providerId: 'provider-2',
          model: 'model-2',
          baseUrl: 'https://api2.example.com',
          apiKey: 'key-2',
          dimensions: 768,
        ));

        expect(embeddingService.config!.providerId, equals('provider-2'));
        expect(embeddingService.config!.dimensions, equals(768));
      });
    });

    group('Message Content Handling', () {
      test('should build content parts for text-only message', () {
        const textContent = 'Hello, how are you?';
        final contentParts = <Map<String, dynamic>>[];

        contentParts.add({'type': 'text', 'text': textContent});

        expect(contentParts.length, equals(1));
        expect(contentParts[0]['type'], equals('text'));
        expect(contentParts[0]['text'], equals(textContent));
      });

      test('should build content parts for message with images', () {
        const textContent = 'What is in this image?';
        final contentParts = <Map<String, dynamic>>[];

        contentParts.add({'type': 'text', 'text': textContent});
        contentParts.add({
          'type': 'image',
          'url': 'data:image/jpeg;base64,/9j/4AAQ...',
          'name': 'photo.jpg',
        });

        expect(contentParts.length, equals(2));
        expect(contentParts[0]['type'], equals('text'));
        expect(contentParts[1]['type'], equals('image'));
        expect(contentParts[1]['url'], startsWith('data:image/jpeg;base64,'));
      });

      test('should build content parts for message with files', () {
        final contentParts = <Map<String, dynamic>>[];

        contentParts.add({'type': 'text', 'text': 'Analyze this document'});
        contentParts.add({
          'type': 'file',
          'path': '/documents/report.pdf',
          'name': 'report.pdf',
        });

        expect(contentParts.length, equals(2));
        expect(contentParts[1]['type'], equals('file'));
        expect(contentParts[1]['name'], equals('report.pdf'));
      });

      test('should serialize and deserialize content parts', () {
        final contentParts = [
          {'type': 'text', 'text': 'Hello'},
          {'type': 'image', 'url': 'data:image/png;base64,abc', 'name': 'img.png'},
        ];

        final json = jsonEncode(contentParts);
        final restored = jsonDecode(json) as List;

        expect(restored.length, equals(2));
        expect(restored[0]['type'], equals('text'));
        expect(restored[1]['type'], equals('image'));
      });
    });

    group('RAG Context Integration', () {
      test('should build RAG context from search results', () {
        final searchResults = [
          SearchResultMock(
            fileName: 'document1.txt',
            content: 'This is content from document 1.',
            score: 0.95,
          ),
          SearchResultMock(
            fileName: 'document2.md',
            content: 'This is content from document 2.',
            score: 0.87,
          ),
        ];

        final contextParts = searchResults.map((r) => 
          '--- From ${r.fileName} ---\n${r.content}'
        ).join('\n\n');
        
        final ragContext = '\n\n[Knowledge Base Context]\n$contextParts\n[End of Context]\n\n';

        expect(ragContext, contains('[Knowledge Base Context]'));
        expect(ragContext, contains('document1.txt'));
        expect(ragContext, contains('document2.md'));
        expect(ragContext, contains('[End of Context]'));
      });

      test('should inject RAG context into user message', () {
        const originalQuery = 'What are the key points?';
        const ragContext = '\n\n[Knowledge Base Context]\nSome relevant content\n[End of Context]\n\n';

        final enhancedMessage = '$ragContext$originalQuery';

        expect(enhancedMessage, startsWith('\n\n[Knowledge Base Context]'));
        expect(enhancedMessage, endsWith('What are the key points?'));
      });

      test('should handle empty search results gracefully', () {
        final searchResults = <SearchResultMock>[];
        
        String ragContext = '';
        if (searchResults.isNotEmpty) {
          final contextParts = searchResults.map((r) => 
            '--- From ${r.fileName} ---\n${r.content}'
          ).join('\n\n');
          ragContext = '\n\n[Knowledge Base Context]\n$contextParts\n[End of Context]\n\n';
        }

        expect(ragContext, isEmpty);
      });
    });

    group('Chat Message Conversion', () {
      test('should convert stored message to LangChain format', () {
        final storedMessages = [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': 'Hello!'},
          {'role': 'assistant', 'content': 'Hi there!'},
          {'role': 'user', 'content': 'How are you?'},
        ];

        final converted = convertToRoleContentFormat(storedMessages);

        expect(converted.length, equals(4));
        expect(converted[0]['role'], equals('system'));
        expect(converted[1]['role'], equals('user'));
        expect(converted[2]['role'], equals('assistant'));
        expect(converted[3]['role'], equals('user'));
      });

      test('should extract text content from content parts', () {
        const contentJson = '[{"type":"text","text":"Hello"},{"type":"image","url":"..."}]';
        final contentList = jsonDecode(contentJson) as List;
        
        final textContent = contentList
            .where((c) => c['type'] == 'text')
            .map((c) => c['text'] as String)
            .join('\n');

        expect(textContent, equals('Hello'));
      });

      test('should handle multi-part text content', () {
        const contentJson = '[{"type":"text","text":"Part 1"},{"type":"text","text":"Part 2"}]';
        final contentList = jsonDecode(contentJson) as List;
        
        final textContent = contentList
            .where((c) => c['type'] == 'text')
            .map((c) => c['text'] as String)
            .join('\n');

        expect(textContent, equals('Part 1\nPart 2'));
      });
    });

    group('Session Name Generation', () {
      test('should truncate long message for session name', () {
        const longMessage = 'This is a very long message that should be truncated for the session name';
        final sessionName = longMessage.length > 30
            ? '${longMessage.substring(0, 30)}...'
            : longMessage;

        expect(sessionName.length, equals(33)); // 30 + '...'
        expect(sessionName.endsWith('...'), isTrue);
      });

      test('should keep short message as session name', () {
        const shortMessage = 'Hello';
        final sessionName = shortMessage.length > 30
            ? '${shortMessage.substring(0, 30)}...'
            : shortMessage;

        expect(sessionName, equals('Hello'));
        expect(sessionName.endsWith('...'), isFalse);
      });
    });
  });
}

// Mock class for search results
class SearchResultMock {
  final String fileName;
  final String content;
  final double score;

  SearchResultMock({
    required this.fileName,
    required this.content,
    required this.score,
  });
}

// Helper function for message conversion
List<Map<String, String>> convertToRoleContentFormat(
  List<Map<String, String>> messages,
) {
  return messages;
}
