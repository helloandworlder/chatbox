import 'package:dio/dio.dart';

import '../domain/provider_config.dart';

/// 从 API 获取可用模型列表
class ModelFetcher {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 10),
  ));

  /// 获取提供商支持的模型列表
  Future<List<ModelConfig>> fetchModels(AIProviderConfig config) async {
    // 对于 custom 类型，根据 apiProtocol 选择不同的获取方式
    if (config.type == AIProviderType.custom) {
      return _fetchByProtocol(config);
    }

    return switch (config.type) {
      AIProviderType.openai => await _fetchOpenAIModels(config),
      AIProviderType.gemini => await _fetchOpenAICompatibleModels(
          config,
          providerDefaultBaseUrls[AIProviderType.gemini]!,
        ),
      AIProviderType.deepseek => await _fetchOpenAICompatibleModels(
          config,
          providerDefaultBaseUrls[AIProviderType.deepseek]!,
        ),
      AIProviderType.openrouter => await _fetchOpenRouterModels(config),
      AIProviderType.ollama => await _fetchOllamaModels(config),
      AIProviderType.claude => await _fetchClaudeModels(config),
      AIProviderType.azure => await _fetchOpenAICompatibleModels(
          config,
          config.baseUrl ?? '',
        ),
      AIProviderType.custom => await _fetchByProtocol(config),
    };
  }

  /// 根据 API 协议类型获取模型
  Future<List<ModelConfig>> _fetchByProtocol(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? '';
    if (baseUrl.isEmpty) {
      throw Exception('Base URL is required for custom provider');
    }

    return switch (config.apiProtocol) {
      APIProtocolType.openai => await _fetchOpenAICompatibleModels(config, baseUrl),
      APIProtocolType.claude => await _fetchClaudeModels(config),
      APIProtocolType.gemini => await _fetchGeminiModels(config),
    };
  }

  /// OpenAI /v1/models
  Future<List<ModelConfig>> _fetchOpenAIModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.openai]!;
    final response = await _dio.get(
      '$baseUrl/models',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${config.apiKey}',
        },
      ),
    );

    final data = response.data;
    final models = (data['data'] as List)
        .map((m) => _parseOpenAIModel(m))
        .where((m) => m != null)
        .cast<ModelConfig>()
        .toList();

    models.sort((a, b) => a.displayName.compareTo(b.displayName));
    return models;
  }

  /// OpenAI 兼容 API (DeepSeek, MiniMax 等)
  Future<List<ModelConfig>> _fetchOpenAICompatibleModels(
    AIProviderConfig config,
    String defaultBaseUrl,
  ) async {
    final baseUrl = config.baseUrl ?? defaultBaseUrl;
    if (baseUrl.isEmpty) return _getDefaultModels(config.type);

    try {
      final response = await _dio.get(
        '$baseUrl/models',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${config.apiKey}',
          },
        ),
      );

      final data = response.data;
      if (data is! Map || data['data'] is! List) {
        throw Exception('Invalid response format');
      }

      final models = (data['data'] as List)
          .map((m) => _parseOpenAIModel(m))
          .where((m) => m != null)
          .cast<ModelConfig>()
          .toList();

      models.sort((a, b) => a.displayName.compareTo(b.displayName));
      return models;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('API does not support /models endpoint. Please add models manually.');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please check your network.');
      }
      rethrow;
    }
  }

  /// 解析 OpenAI 格式的模型数据
  ModelConfig? _parseOpenAIModel(Map<String, dynamic> m) {
    final id = m['id'] as String;
    final modelType = _detectModelType(id);
    
    // 解析能力
    bool supportsVision = false;
    bool supportsReasoning = false;
    bool supportsFunctionCalling = false;
    int? contextWindow;

    // 从 architecture 字段解析能力 (OpenRouter 格式)
    if (m['architecture'] != null) {
      final arch = m['architecture'] as Map<String, dynamic>;
      final inputModalities = arch['input_modalities'] as List?;
      if (inputModalities?.contains('image') == true) {
        supportsVision = true;
      }
    }

    // 从 pricing 字段检测推理能力 (OpenRouter 格式)
    if (m['pricing'] != null) {
      final pricing = m['pricing'] as Map<String, dynamic>;
      if (pricing['internal_reasoning'] != null && pricing['internal_reasoning'] != '0') {
        supportsReasoning = true;
      }
    }

    // 上下文长度
    if (m['context_length'] != null) {
      contextWindow = m['context_length'] as int;
    }

    // 根据模型名称推断能力
    final idLower = id.toLowerCase();
    if (idLower.contains('vision') || idLower.contains('4o') || idLower.contains('gpt-4-turbo')) {
      supportsVision = true;
    }
    if (idLower.contains('o1') || idLower.contains('reasoner') || idLower.contains('r1')) {
      supportsReasoning = true;
    }
    if (!idLower.contains('embedding') && !idLower.contains('tts') && modelType == ModelType.chat) {
      supportsFunctionCalling = true;
    }

    return ModelConfig(
      id: id,
      nickname: m['name'] as String? ?? _formatModelName(id),
      type: modelType,
      supportsVision: supportsVision,
      supportsReasoning: supportsReasoning,
      supportsFunctionCalling: supportsFunctionCalling,
      contextWindow: contextWindow,
    );
  }

  /// Claude API /v1/models
  /// https://docs.anthropic.com/en/docs/api/models
  Future<List<ModelConfig>> _fetchClaudeModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.claude]!;
    
    try {
      final response = await _dio.get(
        '$baseUrl/v1/models',
        options: Options(
          headers: {
            'x-api-key': config.apiKey ?? '',
            'anthropic-version': config.apiVersion ?? '2023-06-01',
          },
        ),
      );

      final data = response.data;
      if (data is! Map || data['data'] is! List) {
        return defaultClaudeModels;
      }

      final models = (data['data'] as List)
          .where((m) => m['type'] == 'model')
          .map((m) {
            final id = m['id'] as String;
            return ModelConfig(
              id: id,
              nickname: _formatModelName(id),
              type: ModelType.chat,
              supportsVision: true,
              supportsFunctionCalling: true,
            );
          })
          .toList();

      if (models.isEmpty) return defaultClaudeModels;
      models.sort((a, b) => a.displayName.compareTo(b.displayName));
      return models;
    } catch (e) {
      // Claude API 可能不支持 /models，返回默认列表
      return defaultClaudeModels;
    }
  }

  /// Gemini API (Google AI)
  /// https://ai.google.dev/api/models#method:-models.list
  Future<List<ModelConfig>> _fetchGeminiModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? 'https://generativelanguage.googleapis.com/v1beta';
    
    try {
      final response = await _dio.get(
        '$baseUrl/models',
        queryParameters: {
          'key': config.apiKey,
        },
      );

      final data = response.data;
      if (data is! Map || data['models'] is! List) {
        return defaultGeminiModels;
      }

      final models = (data['models'] as List)
          .where((m) {
            final methods = m['supportedGenerationMethods'] as List?;
            return methods?.contains('generateContent') == true;
          })
          .map((m) {
            final name = m['name'] as String; // format: models/gemini-pro
            final id = name.replaceFirst('models/', '');
            final displayName = m['displayName'] as String? ?? id;
            
            // 检测能力
            final methods = m['supportedGenerationMethods'] as List? ?? [];
            final inputLimits = m['inputTokenLimit'] as int?;
            final outputLimits = m['outputTokenLimit'] as int?;
            
            return ModelConfig(
              id: id,
              nickname: displayName,
              type: ModelType.chat,
              supportsVision: id.contains('vision') || id.contains('pro') || id.contains('flash'),
              supportsFunctionCalling: methods.contains('generateContent'),
              contextWindow: inputLimits,
              maxOutputTokens: outputLimits,
            );
          })
          .toList();

      if (models.isEmpty) return defaultGeminiModels;
      models.sort((a, b) => a.displayName.compareTo(b.displayName));
      return models;
    } catch (e) {
      return defaultGeminiModels;
    }
  }

  /// OpenRouter 模型列表 (包含更多元数据)
  Future<List<ModelConfig>> _fetchOpenRouterModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.openrouter]!;
    final response = await _dio.get(
      '$baseUrl/models',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${config.apiKey}',
        },
      ),
    );

    final data = response.data;
    final models = (data['data'] as List)
        .map((m) => _parseOpenAIModel(m))
        .where((m) => m != null)
        .cast<ModelConfig>()
        .toList();

    models.sort((a, b) => a.displayName.compareTo(b.displayName));
    return models;
  }

  /// Ollama 本地模型列表
  Future<List<ModelConfig>> _fetchOllamaModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.ollama]!;
    final tagsUrl = baseUrl.endsWith('/api')
        ? '$baseUrl/tags'
        : '$baseUrl/api/tags';

    final response = await _dio.get(tagsUrl);

    final data = response.data;
    final models = (data['models'] as List)
        .map((m) {
          final name = m['name'] as String;
          
          return ModelConfig(
            id: name,
            nickname: _formatModelName(name),
            type: ModelType.chat,
            supportsVision: name.contains('llava') || name.contains('vision'),
            supportsReasoning: name.contains('r1') || name.contains('reasoner'),
          );
        })
        .toList();

    models.sort((a, b) => a.displayName.compareTo(b.displayName));
    return models;
  }

  /// 检测模型类型
  ModelType _detectModelType(String modelId) {
    final id = modelId.toLowerCase();
    if (id.contains('embedding') || id.contains('embed')) {
      return ModelType.embedding;
    }
    if (id.contains('rerank')) {
      return ModelType.rerank;
    }
    return ModelType.chat;
  }

  /// 格式化模型名称
  String _formatModelName(String modelId) {
    var name = modelId;
    if (name.contains('/')) {
      name = name.split('/').last;
    }

    name = name.replaceAll('-', ' ').replaceAll('_', ' ');

    name = name.split(' ').map((word) {
      if (word.isEmpty) return word;
      if (word.toUpperCase() == word && word.length <= 4) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return name;
  }

  /// 获取默认模型列表
  List<ModelConfig> _getDefaultModels(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => defaultOpenAIModels,
      AIProviderType.claude => defaultClaudeModels,
      AIProviderType.gemini => defaultGeminiModels,
      AIProviderType.deepseek => defaultDeepSeekModels,
      AIProviderType.openrouter => defaultOpenRouterModels,
      AIProviderType.ollama => defaultOllamaModels,
      _ => [],
    };
  }
}
