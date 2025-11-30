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
      apiPath: json['apiPath'] as String?,
      apiVersion: json['apiVersion'] as String?,
      apiProtocol:
          $enumDecodeNullable(_$APIProtocolTypeEnumMap, json['apiProtocol']) ??
              APIProtocolType.openai,
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
      'apiPath': instance.apiPath,
      'apiVersion': instance.apiVersion,
      'apiProtocol': _$APIProtocolTypeEnumMap[instance.apiProtocol]!,
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

const _$APIProtocolTypeEnumMap = {
  APIProtocolType.openai: 'openai',
  APIProtocolType.claude: 'claude',
  APIProtocolType.gemini: 'gemini',
};

_$ModelConfigImpl _$$ModelConfigImplFromJson(Map<String, dynamic> json) =>
    _$ModelConfigImpl(
      id: json['id'] as String,
      nickname: json['nickname'] as String?,
      type: $enumDecodeNullable(_$ModelTypeEnumMap, json['type']) ??
          ModelType.chat,
      supportsVision: json['supportsVision'] as bool? ?? false,
      supportsReasoning: json['supportsReasoning'] as bool? ?? false,
      supportsFunctionCalling:
          json['supportsFunctionCalling'] as bool? ?? false,
      maxOutputTokens: (json['maxOutputTokens'] as num?)?.toInt(),
      contextWindow: (json['contextWindow'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ModelConfigImplToJson(_$ModelConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'type': _$ModelTypeEnumMap[instance.type]!,
      'supportsVision': instance.supportsVision,
      'supportsReasoning': instance.supportsReasoning,
      'supportsFunctionCalling': instance.supportsFunctionCalling,
      'maxOutputTokens': instance.maxOutputTokens,
      'contextWindow': instance.contextWindow,
    };

const _$ModelTypeEnumMap = {
  ModelType.chat: 'chat',
  ModelType.embedding: 'embedding',
  ModelType.rerank: 'rerank',
};
