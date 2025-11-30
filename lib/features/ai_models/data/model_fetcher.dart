import 'package:dio/dio.dart';

import '../domain/provider_config.dart';

/// 从 API 获取可用模型列表
class ModelFetcher {
  final Dio _dio = Dio();

  /// 获取提供商支持的模型列表
  /// 
  /// 支持的 API:
  /// - OpenAI: GET /v1/models
  /// - Gemini: GET /v1beta/openai/models (OpenAI 兼容)
  /// - DeepSeek: GET /v1/models (OpenAI 兼容)
  /// - OpenRouter: GET /api/v1/models (OpenAI 兼容)
  /// - Ollama: GET /api/tags
  /// - Claude: 无官方 API，返回默认列表
  Future<List<ModelConfig>> fetchModels(AIProviderConfig config) async {
    try {
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
        AIProviderType.claude => defaultClaudeModels, // Claude 无模型列表 API
        AIProviderType.azure => await _fetchOpenAICompatibleModels(
            config,
            config.baseUrl ?? '',
          ),
        AIProviderType.custom => await _fetchOpenAICompatibleModels(
            config,
            config.baseUrl ?? '',
          ),
      };
    } catch (e) {
      // 获取失败时返回默认模型
      return _getDefaultModels(config.type);
    }
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
        .where((m) => _isUsableChatModel(m['id'] as String))
        .map((m) => ModelConfig(
              id: m['id'] as String,
              name: _formatModelName(m['id'] as String),
            ))
        .toList();

    // 按名称排序
    models.sort((a, b) => a.name.compareTo(b.name));
    return models;
  }

  /// OpenAI 兼容 API (Gemini, DeepSeek 等)
  Future<List<ModelConfig>> _fetchOpenAICompatibleModels(
    AIProviderConfig config,
    String defaultBaseUrl,
  ) async {
    final baseUrl = config.baseUrl ?? defaultBaseUrl;
    if (baseUrl.isEmpty) return _getDefaultModels(config.type);

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
        .map((m) => ModelConfig(
              id: m['id'] as String,
              name: _formatModelName(m['id'] as String),
            ))
        .toList();

    models.sort((a, b) => a.name.compareTo(b.name));
    return models;
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
        .map((m) {
          final contextLength = m['context_length'];
          return ModelConfig(
            id: m['id'] as String,
            name: m['name'] as String? ?? _formatModelName(m['id'] as String),
            contextWindow: contextLength is int ? contextLength : null,
          );
        })
        .toList();

    models.sort((a, b) => a.name.compareTo(b.name));
    return models;
  }

  /// Ollama 本地模型列表
  Future<List<ModelConfig>> _fetchOllamaModels(AIProviderConfig config) async {
    final baseUrl = config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.ollama]!;
    // Ollama 使用 /api/tags 端点
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
            name: _formatModelName(name),
          );
        })
        .toList();

    models.sort((a, b) => a.name.compareTo(b.name));
    return models;
  }

  /// 过滤可用的聊天模型 (排除 embedding, tts 等)
  bool _isUsableChatModel(String modelId) {
    final id = modelId.toLowerCase();
    // 排除非聊天模型
    if (id.contains('embedding') || 
        id.contains('embed') ||
        id.contains('tts') ||
        id.contains('whisper') ||
        id.contains('dall-e') ||
        id.contains('davinci') ||
        id.contains('babbage') ||
        id.contains('curie') ||
        id.contains('ada') && !id.contains('ada-') ||
        id.contains('moderation')) {
      return false;
    }
    return true;
  }

  /// 格式化模型名称
  String _formatModelName(String modelId) {
    // 移除提供商前缀 (openai/, anthropic/ 等)
    var name = modelId;
    if (name.contains('/')) {
      name = name.split('/').last;
    }
    
    // 转换为更友好的名称
    name = name.replaceAll('-', ' ').replaceAll('_', ' ');
    
    // 首字母大写
    name = name.split(' ').map((word) {
      if (word.isEmpty) return word;
      // 保持全大写的缩写 (GPT, API 等)
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
