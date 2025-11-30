import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_config.freezed.dart';
part 'provider_config.g.dart';

/// AI Provider 类型（预设的服务商）
enum AIProviderType { 
  openai, 
  claude, 
  gemini, 
  ollama, 
  deepseek, 
  openrouter, 
  azure, 
  custom 
}

/// API 协议类型（用于 custom provider 指定 API 格式）
enum APIProtocolType {
  openai,   // OpenAI API 兼容
  claude,   // Anthropic Message API
  gemini,   // Google Gemini API
}

/// 模型类型
enum ModelType {
  chat,       // 聊天模型
  embedding,  // 嵌入模型
  rerank,     // 重排模型
}

@freezed
class AIProviderConfig with _$AIProviderConfig {
  const factory AIProviderConfig({
    required String id,
    required AIProviderType type,
    required String name,
    String? apiKey,
    String? baseUrl,
    String? apiPath,  // 自定义 API 路径，如 /chat/completions
    String? apiVersion,
    @Default(APIProtocolType.openai) APIProtocolType apiProtocol,
    @Default(true) bool enabled,
    @Default([]) List<ModelConfig> models,
  }) = _AIProviderConfig;

  factory AIProviderConfig.fromJson(Map<String, dynamic> json) =>
      _$AIProviderConfigFromJson(json);
}

@freezed
class ModelConfig with _$ModelConfig {
  const factory ModelConfig({
    required String id,
    String? nickname,  // 显示名称
    @Default(ModelType.chat) ModelType type,
    @Default(false) bool supportsVision,
    @Default(false) bool supportsReasoning,
    @Default(false) bool supportsFunctionCalling,
    int? maxOutputTokens,
    int? contextWindow,
  }) = _ModelConfig;

  factory ModelConfig.fromJson(Map<String, dynamic> json) =>
      _$ModelConfigFromJson(json);
}

/// 获取模型显示名称
extension ModelConfigExtension on ModelConfig {
  String get displayName => nickname ?? id;
}

// ========== 内置提供商配置 ==========

const defaultOpenAIModels = [
  ModelConfig(
    id: 'gpt-4o',
    nickname: 'GPT-4o',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
  ModelConfig(
    id: 'gpt-4o-mini',
    nickname: 'GPT-4o Mini',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
  ModelConfig(
    id: 'o1',
    nickname: 'o1',
    supportsVision: true,
    supportsReasoning: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'o1-mini',
    nickname: 'o1 Mini',
    supportsReasoning: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
  ModelConfig(
    id: 'gpt-4-turbo',
    nickname: 'GPT-4 Turbo',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
];

const defaultClaudeModels = [
  ModelConfig(
    id: 'claude-sonnet-4-20250514',
    nickname: 'Claude Sonnet 4',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-5-sonnet-20241022',
    nickname: 'Claude 3.5 Sonnet',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-5-haiku-20241022',
    nickname: 'Claude 3.5 Haiku',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-opus-20240229',
    nickname: 'Claude 3 Opus',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
];

// Gemini 支持 OpenAI 兼容 API
const defaultGeminiModels = [
  ModelConfig(
    id: 'gemini-2.5-pro-preview-06-05',
    nickname: 'Gemini 2.5 Pro',
    supportsVision: true,
    supportsReasoning: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-2.5-flash-preview-05-20',
    nickname: 'Gemini 2.5 Flash',
    supportsVision: true,
    supportsReasoning: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-2.0-flash',
    nickname: 'Gemini 2.0 Flash',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-1.5-pro',
    nickname: 'Gemini 1.5 Pro',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 2000000,
  ),
];

const defaultDeepSeekModels = [
  ModelConfig(
    id: 'deepseek-chat',
    nickname: 'DeepSeek V3',
    supportsFunctionCalling: true,
    contextWindow: 64000,
  ),
  ModelConfig(
    id: 'deepseek-reasoner',
    nickname: 'DeepSeek R1',
    supportsReasoning: true,
    contextWindow: 64000,
  ),
];

// OpenRouter 提供统一访问多个模型
const defaultOpenRouterModels = [
  ModelConfig(
    id: 'openai/gpt-4o',
    nickname: 'GPT-4o (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'anthropic/claude-3.5-sonnet',
    nickname: 'Claude 3.5 Sonnet (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'google/gemini-2.0-flash-001',
    nickname: 'Gemini 2.0 Flash (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'deepseek/deepseek-chat-v3-0324',
    nickname: 'DeepSeek V3 (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'meta-llama/llama-3.3-70b-instruct',
    nickname: 'Llama 3.3 70B (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'qwen/qwen-2.5-72b-instruct',
    nickname: 'Qwen 2.5 72B (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
];

const defaultOllamaModels = [
  ModelConfig(
    id: 'llama3.3',
    nickname: 'Llama 3.3',
    contextWindow: 131072,
  ),
  ModelConfig(
    id: 'qwen2.5',
    nickname: 'Qwen 2.5',
    contextWindow: 131072,
  ),
  ModelConfig(
    id: 'deepseek-r1',
    nickname: 'DeepSeek R1',
    supportsReasoning: true,
    contextWindow: 65536,
  ),
  ModelConfig(
    id: 'gemma2',
    nickname: 'Gemma 2',
    contextWindow: 8192,
  ),
];

// 预设提供商的默认 Base URL
const providerDefaultBaseUrls = {
  AIProviderType.openai: 'https://api.openai.com/v1',
  AIProviderType.claude: 'https://api.anthropic.com',
  AIProviderType.gemini: 'https://generativelanguage.googleapis.com/v1beta/openai',
  AIProviderType.deepseek: 'https://api.deepseek.com/v1',
  AIProviderType.openrouter: 'https://openrouter.ai/api/v1',
  AIProviderType.ollama: 'http://localhost:11434/api',
};
