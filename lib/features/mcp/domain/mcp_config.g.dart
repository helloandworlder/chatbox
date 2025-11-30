// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPServerConfigImpl _$$MCPServerConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServerConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      enabled: json['enabled'] as bool? ?? false,
      transport: MCPTransportConfig.fromJson(
          json['transport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MCPServerConfigImplToJson(
        _$MCPServerConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'enabled': instance.enabled,
      'transport': instance.transport,
    };

_$MCPStdioTransportConfigImpl _$$MCPStdioTransportConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPStdioTransportConfigImpl(
      command: json['command'] as String,
      args:
          (json['args'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      env: (json['env'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MCPStdioTransportConfigImplToJson(
        _$MCPStdioTransportConfigImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'args': instance.args,
      'env': instance.env,
      'type': instance.$type,
    };

_$MCPHttpTransportConfigImpl _$$MCPHttpTransportConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPHttpTransportConfigImpl(
      url: json['url'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MCPHttpTransportConfigImplToJson(
        _$MCPHttpTransportConfigImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
      'type': instance.$type,
    };

_$MCPSseTransportConfigImpl _$$MCPSseTransportConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPSseTransportConfigImpl(
      url: json['url'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MCPSseTransportConfigImplToJson(
        _$MCPSseTransportConfigImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
      'type': instance.$type,
    };

_$MCPToolInfoImpl _$$MCPToolInfoImplFromJson(Map<String, dynamic> json) =>
    _$MCPToolInfoImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      inputSchema: json['inputSchema'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MCPToolInfoImplToJson(_$MCPToolInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'inputSchema': instance.inputSchema,
    };
