// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageEntityImpl _$$MessageEntityImplFromJson(Map<String, dynamic> json) =>
    _$MessageEntityImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      role: $enumDecode(_$MessageRoleEnumMap, json['role']),
      content: (json['content'] as List<dynamic>)
          .map((e) => ContentPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      model: json['model'] as String?,
      inputTokens: (json['inputTokens'] as num?)?.toInt(),
      outputTokens: (json['outputTokens'] as num?)?.toInt(),
      generating: json['generating'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MessageEntityImplToJson(_$MessageEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'role': _$MessageRoleEnumMap[instance.role]!,
      'content': instance.content,
      'model': instance.model,
      'inputTokens': instance.inputTokens,
      'outputTokens': instance.outputTokens,
      'generating': instance.generating,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.assistant: 'assistant',
  MessageRole.system: 'system',
};

_$TextContentImpl _$$TextContentImplFromJson(Map<String, dynamic> json) =>
    _$TextContentImpl(
      text: json['text'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TextContentImplToJson(_$TextContentImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'runtimeType': instance.$type,
    };

_$ImageContentImpl _$$ImageContentImplFromJson(Map<String, dynamic> json) =>
    _$ImageContentImpl(
      url: json['url'] as String,
      alt: json['alt'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ImageContentImplToJson(_$ImageContentImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'alt': instance.alt,
      'runtimeType': instance.$type,
    };

_$FileContentImpl _$$FileContentImplFromJson(Map<String, dynamic> json) =>
    _$FileContentImpl(
      path: json['path'] as String,
      name: json['name'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FileContentImplToJson(_$FileContentImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'runtimeType': instance.$type,
    };
