// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'copilot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CopilotEntityImpl _$$CopilotEntityImplFromJson(Map<String, dynamic> json) =>
    _$CopilotEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      picUrl: json['picUrl'] as String?,
      prompt: json['prompt'] as String,
      starred: json['starred'] as bool? ?? false,
      usedCount: (json['usedCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CopilotEntityImplToJson(_$CopilotEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'prompt': instance.prompt,
      'starred': instance.starred,
      'usedCount': instance.usedCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
