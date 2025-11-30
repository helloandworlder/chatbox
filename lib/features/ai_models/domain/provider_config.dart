import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_config.freezed.dart';
part 'provider_config.g.dart';

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

@freezed
class AIProviderConfig with _$AIProviderConfig {
  const factory AIProviderConfig({
    required String id,
    required AIProviderType type,
    required String name,
    String? apiKey,
    String? baseUrl,
    String? apiVersion,
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
    required String name,
    @Default(true) bool supportsStreaming,
    @Default(false) bool supportsVision,
    @Default(false) bool supportsFunctionCalling,
    int? maxTokens,
    int? contextWindow,
  }) = _ModelConfig;

  factory ModelConfig.fromJson(Map<String, dynamic> json) =>
      _$ModelConfigFromJson(json);
}

// ========== 内置提供商配置 ==========

const defaultOpenAIModels = [
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
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
  ModelConfig(
    id: 'o1',
    name: 'o1',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'o1-mini',
    name: 'o1 Mini',
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
  ModelConfig(
    id: 'gpt-4-turbo',
    name: 'GPT-4 Turbo',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 128000,
  ),
];

const defaultClaudeModels = [
  ModelConfig(
    id: 'claude-sonnet-4-20250514',
    name: 'Claude Sonnet 4',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-5-sonnet-20241022',
    name: 'Claude 3.5 Sonnet',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-5-haiku-20241022',
    name: 'Claude 3.5 Haiku',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
  ModelConfig(
    id: 'claude-3-opus-20240229',
    name: 'Claude 3 Opus',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 200000,
  ),
];

// Gemini 支持 OpenAI 兼容 API
const defaultGeminiModels = [
  ModelConfig(
    id: 'gemini-2.5-pro-preview-06-05',
    name: 'Gemini 2.5 Pro',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-2.5-flash-preview-05-20',
    name: 'Gemini 2.5 Flash',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-2.0-flash',
    name: 'Gemini 2.0 Flash',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 1048576,
  ),
  ModelConfig(
    id: 'gemini-1.5-pro',
    name: 'Gemini 1.5 Pro',
    supportsVision: true,
    supportsFunctionCalling: true,
    contextWindow: 2000000,
  ),
];

const defaultDeepSeekModels = [
  ModelConfig(
    id: 'deepseek-chat',
    name: 'DeepSeek V3',
    supportsFunctionCalling: true,
    contextWindow: 64000,
  ),
  ModelConfig(
    id: 'deepseek-reasoner',
    name: 'DeepSeek R1',
    contextWindow: 64000,
  ),
];

// OpenRouter 提供统一访问多个模型
const defaultOpenRouterModels = [
  ModelConfig(
    id: 'openai/gpt-4o',
    name: 'GPT-4o (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'anthropic/claude-3.5-sonnet',
    name: 'Claude 3.5 Sonnet (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'google/gemini-2.0-flash-001',
    name: 'Gemini 2.0 Flash (via OpenRouter)',
    supportsVision: true,
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'deepseek/deepseek-chat-v3-0324',
    name: 'DeepSeek V3 (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'meta-llama/llama-3.3-70b-instruct',
    name: 'Llama 3.3 70B (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
  ModelConfig(
    id: 'qwen/qwen-2.5-72b-instruct',
    name: 'Qwen 2.5 72B (via OpenRouter)',
    supportsFunctionCalling: true,
  ),
];

const defaultOllamaModels = [
  ModelConfig(
    id: 'llama3.3',
    name: 'Llama 3.3',
    contextWindow: 131072,
  ),
  ModelConfig(
    id: 'qwen2.5',
    name: 'Qwen 2.5',
    contextWindow: 131072,
  ),
  ModelConfig(
    id: 'deepseek-r1',
    name: 'DeepSeek R1',
    contextWindow: 65536,
  ),
  ModelConfig(
    id: 'gemma2',
    name: 'Gemma 2',
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
