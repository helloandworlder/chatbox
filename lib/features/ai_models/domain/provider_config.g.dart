// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIProviderConfigImpl _$$AIProviderConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$AIProviderConfigImpl(
      id: json['id'] as String,
      type: $enumDecode(_$AIProviderTypeEnumMap, json['type']),
      name: json['name'] as String,
      apiKey: json['apiKey'] as String?,
      baseUrl: json['baseUrl'] as String?,
      apiVersion: json['apiVersion'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      models: (json['models'] as List<dynamic>?)
              ?.map((e) => ModelConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AIProviderConfigImplToJson(
        _$AIProviderConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AIProviderTypeEnumMap[instance.type]!,
      'name': instance.name,
      'apiKey': instance.apiKey,
      'baseUrl': instance.baseUrl,
      'apiVersion': instance.apiVersion,
      'enabled': instance.enabled,
      'models': instance.models,
    };

const _$AIProviderTypeEnumMap = {
  AIProviderType.openai: 'openai',
  AIProviderType.claude: 'claude',
  AIProviderType.gemini: 'gemini',
  AIProviderType.ollama: 'ollama',
  AIProviderType.deepseek: 'deepseek',
  AIProviderType.openrouter: 'openrouter',
  AIProviderType.azure: 'azure',
  AIProviderType.custom: 'custom',
};

_$ModelConfigImpl _$$ModelConfigImplFromJson(Map<String, dynamic> json) =>
    _$ModelConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      supportsStreaming: json['supportsStreaming'] as bool? ?? true,
      supportsVision: json['supportsVision'] as bool? ?? false,
      supportsFunctionCalling:
          json['supportsFunctionCalling'] as bool? ?? false,
      maxTokens: (json['maxTokens'] as num?)?.toInt(),
      contextWindow: (json['contextWindow'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ModelConfigImplToJson(_$ModelConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'supportsStreaming': instance.supportsStreaming,
      'supportsVision': instance.supportsVision,
      'supportsFunctionCalling': instance.supportsFunctionCalling,
      'maxTokens': instance.maxTokens,
      'contextWindow': instance.contextWindow,
    };
