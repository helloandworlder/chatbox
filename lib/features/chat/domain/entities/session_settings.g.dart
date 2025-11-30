// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionSettingsImpl _$$SessionSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionSettingsImpl(
      systemPrompt: json['systemPrompt'] as String?,
      maxContextMessages: (json['maxContextMessages'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['topP'] as num?)?.toDouble(),
      maxOutputTokens: (json['maxOutputTokens'] as num?)?.toInt(),
      streamingOutput: json['streamingOutput'] as bool? ?? true,
    );

Map<String, dynamic> _$$SessionSettingsImplToJson(
        _$SessionSettingsImpl instance) =>
    <String, dynamic>{
      'systemPrompt': instance.systemPrompt,
      'maxContextMessages': instance.maxContextMessages,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'maxOutputTokens': instance.maxOutputTokens,
      'streamingOutput': instance.streamingOutput,
    };
