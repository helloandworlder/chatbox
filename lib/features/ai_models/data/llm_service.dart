import 'dart:async';

import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:langchain_anthropic/langchain_anthropic.dart';
import 'package:langchain_ollama/langchain_ollama.dart';

import '../domain/provider_config.dart';

/// 流式响应块
class ChatChunk {
  final String? text;
  final bool isFinished;
  final String? finishReason;
  final int? inputTokens;
  final int? outputTokens;

  ChatChunk({
    this.text,
    this.isFinished = false,
    this.finishReason,
    this.inputTokens,
    this.outputTokens,
  });
}

/// LLM 服务封装
/// 
/// 支持的提供商:
/// - OpenAI: 使用 Chat Completions API (langchain_openai)
/// - Claude: 使用原生 Messages API (langchain_anthropic)
/// - Gemini: 使用 OpenAI 兼容 API (google_generative_ai 已废弃)
/// - DeepSeek: OpenAI 兼容 API
/// - OpenRouter: OpenAI 兼容 API (统一访问多模型)
/// - Ollama: 本地模型 (langchain_ollama)
class LLMService {
  final Map<String, BaseChatModel> _chatModels = {};
  final Map<String, AIProviderConfig> _configs = {};

  void registerProvider(AIProviderConfig config) {
    if (config.apiKey == null || config.apiKey!.isEmpty) {
      // Ollama 不需要 API key
      if (config.type != AIProviderType.ollama) {
        return;
      }
    }
    _configs[config.id] = config;

    switch (config.type) {
      case AIProviderType.openai:
        _registerOpenAI(config);
        break;
      case AIProviderType.claude:
        _registerClaude(config);
        break;
      case AIProviderType.gemini:
        // Gemini 支持 OpenAI 兼容 API
        _registerOpenAICompatible(
          config,
          providerDefaultBaseUrls[AIProviderType.gemini]!,
        );
        break;
      case AIProviderType.deepseek:
        // DeepSeek 使用 OpenAI 兼容 API
        _registerOpenAICompatible(
          config,
          providerDefaultBaseUrls[AIProviderType.deepseek]!,
        );
        break;
      case AIProviderType.openrouter:
        // OpenRouter 使用 OpenAI 兼容 API
        _registerOpenAICompatible(
          config,
          providerDefaultBaseUrls[AIProviderType.openrouter]!,
        );
        break;
      case AIProviderType.ollama:
        _registerOllama(config);
        break;
      case AIProviderType.azure:
        _registerAzure(config);
        break;
      case AIProviderType.custom:
        _registerCustomOpenAI(config);
        break;
    }
  }

  /// OpenAI - 使用 Chat Completions API
  void _registerOpenAI(AIProviderConfig config) {
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatOpenAI(
        apiKey: config.apiKey!,
        baseUrl: config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.openai]!,
        defaultOptions: ChatOpenAIOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  /// Claude - 使用原生 Anthropic Messages API
  void _registerClaude(AIProviderConfig config) {
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatAnthropic(
        apiKey: config.apiKey!,
        defaultOptions: ChatAnthropicOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  /// OpenAI 兼容 API (Gemini, DeepSeek, OpenRouter 等)
  void _registerOpenAICompatible(AIProviderConfig config, String defaultBaseUrl) {
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatOpenAI(
        apiKey: config.apiKey!,
        baseUrl: config.baseUrl ?? defaultBaseUrl,
        defaultOptions: ChatOpenAIOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  /// Ollama - 本地模型
  void _registerOllama(AIProviderConfig config) {
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatOllama(
        baseUrl: config.baseUrl ?? providerDefaultBaseUrls[AIProviderType.ollama]!,
        defaultOptions: ChatOllamaOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  /// Azure OpenAI
  void _registerAzure(AIProviderConfig config) {
    if (config.baseUrl == null) return;
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatOpenAI(
        apiKey: config.apiKey!,
        baseUrl: config.baseUrl!,
        defaultOptions: ChatOpenAIOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  /// 自定义 OpenAI 兼容 API
  void _registerCustomOpenAI(AIProviderConfig config) {
    if (config.baseUrl == null) return;
    for (final model in config.models) {
      final key = '${config.id}:${model.id}';
      _chatModels[key] = ChatOpenAI(
        apiKey: config.apiKey!,
        baseUrl: config.baseUrl!,
        defaultOptions: ChatOpenAIOptions(
          model: model.id,
          temperature: 0.7,
        ),
      );
    }
  }

  void unregisterProvider(String providerId) {
    _configs.remove(providerId);
    _chatModels.removeWhere((key, _) => key.startsWith('$providerId:'));
  }

  bool hasProvider(String providerId) => _configs.containsKey(providerId);

  List<String> getAvailableModels(String providerId) {
    return _chatModels.keys
        .where((key) => key.startsWith('$providerId:'))
        .map((key) => key.split(':')[1])
        .toList();
  }

  BaseChatModel? getModel(String providerId, String modelId) {
    return _chatModels['$providerId:$modelId'];
  }

  Stream<ChatChunk> streamChat({
    required String providerId,
    required String modelId,
    required List<ChatMessage> messages,
  }) async* {
    final model = getModel(providerId, modelId);
    if (model == null) {
      throw Exception('Model $providerId:$modelId not found');
    }

    final stream = model.stream(PromptValue.chat(messages));

    await for (final chunk in stream) {
      final text = chunk.output.content;
      yield ChatChunk(text: text);
    }

    yield ChatChunk(
      isFinished: true,
      finishReason: 'stop',
    );
  }

  Future<String> chat({
    required String providerId,
    required String modelId,
    required List<ChatMessage> messages,
  }) async {
    final model = getModel(providerId, modelId);
    if (model == null) {
      throw Exception('Model $providerId:$modelId not found');
    }

    final result = await model.invoke(PromptValue.chat(messages));
    return result.output.content;
  }
}

extension ChatMessageConverter on List<Map<String, dynamic>> {
  List<ChatMessage> toChatMessages() {
    return map((m) {
      final role = m['role'] as String;
      final content = m['content'] as String;
      return switch (role) {
        'user' => ChatMessage.humanText(content),
        'assistant' => ChatMessage.ai(content),
        'system' => ChatMessage.system(content),
        _ => ChatMessage.humanText(content),
      };
    }).toList();
  }
}
