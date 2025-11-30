// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionEntityImpl _$$SessionEntityImplFromJson(Map<String, dynamic> json) =>
    _$SessionEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String? ?? 'chat',
      starred: json['starred'] as bool? ?? false,
      copilotId: json['copilotId'] as String?,
      settings: json['settings'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SessionEntityImplToJson(_$SessionEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'starred': instance.starred,
      'copilotId': instance.copilotId,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
