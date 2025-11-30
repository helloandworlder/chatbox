import 'dart:convert';
import 'package:dio/dio.dart';

/// Embedding 模型配置
class EmbeddingModelConfig {
  final String providerId;
  final String model;
  final String baseUrl;
  final String apiKey;
  final int dimensions;

  const EmbeddingModelConfig({
    required this.providerId,
    required this.model,
    required this.baseUrl,
    required this.apiKey,
    required this.dimensions,
  });

  static const defaultOpenAI = EmbeddingModelConfig(
    providerId: 'openai',
    model: 'text-embedding-3-small',
    baseUrl: 'https://api.openai.com/v1',
    apiKey: '',
    dimensions: 1536,
  );

  static const defaultOpenAILarge = EmbeddingModelConfig(
    providerId: 'openai',
    model: 'text-embedding-3-large',
    baseUrl: 'https://api.openai.com/v1',
    apiKey: '',
    dimensions: 3072,
  );

  EmbeddingModelConfig copyWith({
    String? providerId,
    String? model,
    String? baseUrl,
    String? apiKey,
    int? dimensions,
  }) {
    return EmbeddingModelConfig(
      providerId: providerId ?? this.providerId,
      model: model ?? this.model,
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      dimensions: dimensions ?? this.dimensions,
    );
  }
}

/// Embedding 服务
/// 支持 OpenAI 及其兼容 API (如 Azure, Ollama)
class EmbeddingService {
  final Dio _dio;
  EmbeddingModelConfig? _config;

  EmbeddingService() : _dio = Dio();

  void configure(EmbeddingModelConfig config) {
    _config = config;
  }

  EmbeddingModelConfig? get config => _config;

  bool get isConfigured => _config != null && _config!.apiKey.isNotEmpty;

  /// 生成单个文本的 embedding
  Future<List<double>> embed(String text) async {
    if (_config == null) {
      throw Exception('EmbeddingService not configured');
    }

    final response = await _dio.post(
      '${_config!.baseUrl}/embeddings',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${_config!.apiKey}',
          'Content-Type': 'application/json',
        },
      ),
      data: jsonEncode({
        'model': _config!.model,
        'input': text,
        'dimensions': _config!.dimensions,
      }),
    );

    final data = response.data as Map<String, dynamic>;
    final embeddings = data['data'] as List;
    final embedding = embeddings[0]['embedding'] as List;
    return embedding.map((e) => (e as num).toDouble()).toList();
  }

  /// 批量生成 embeddings
  Future<List<List<double>>> embedBatch(List<String> texts) async {
    if (_config == null) {
      throw Exception('EmbeddingService not configured');
    }

    if (texts.isEmpty) return [];

    // OpenAI API 单次最多支持 2048 个输入
    const batchSize = 100;
    final results = <List<double>>[];

    for (var i = 0; i < texts.length; i += batchSize) {
      final batch = texts.sublist(
        i,
        (i + batchSize > texts.length) ? texts.length : i + batchSize,
      );

      final response = await _dio.post(
        '${_config!.baseUrl}/embeddings',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_config!.apiKey}',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({
          'model': _config!.model,
          'input': batch,
          'dimensions': _config!.dimensions,
        }),
      );

      final data = response.data as Map<String, dynamic>;
      final embeddings = data['data'] as List;

      // 按 index 排序确保顺序正确
      embeddings.sort((a, b) => (a['index'] as int).compareTo(b['index'] as int));

      for (final item in embeddings) {
        final embedding = item['embedding'] as List;
        results.add(embedding.map((e) => (e as num).toDouble()).toList());
      }
    }

    return results;
  }
}
