import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcp_config.freezed.dart';
part 'mcp_config.g.dart';

/// MCP 服务器状态
enum MCPServerState {
  idle,
  starting,
  running,
  stopping,
}

/// MCP 服务器配置
@freezed
class MCPServerConfig with _$MCPServerConfig {
  const factory MCPServerConfig({
    required String id,
    required String name,
    @Default(false) bool enabled,
    required MCPTransportConfig transport,
  }) = _MCPServerConfig;

  factory MCPServerConfig.fromJson(Map<String, dynamic> json) =>
      _$MCPServerConfigFromJson(json);
}

/// MCP 传输层配置 (sealed class)
@Freezed(unionKey: 'type')
sealed class MCPTransportConfig with _$MCPTransportConfig {
  const factory MCPTransportConfig.stdio({
    required String command,
    @Default([]) List<String> args,
    @Default({}) Map<String, String> env,
  }) = MCPStdioTransportConfig;

  const factory MCPTransportConfig.http({
    required String url,
    @Default({}) Map<String, String> headers,
  }) = MCPHttpTransportConfig;

  const factory MCPTransportConfig.sse({
    required String url,
    @Default({}) Map<String, String> headers,
  }) = MCPSseTransportConfig;

  factory MCPTransportConfig.fromJson(Map<String, dynamic> json) =>
      _$MCPTransportConfigFromJson(json);
}

/// MCP 服务器状态 (含错误信息)
@freezed
class MCPServerStatus with _$MCPServerStatus {
  const factory MCPServerStatus({
    required MCPServerState state,
    String? error,
    @Default([]) List<MCPToolInfo> tools,
  }) = _MCPServerStatus;

  factory MCPServerStatus.idle() => const MCPServerStatus(state: MCPServerState.idle);
  factory MCPServerStatus.starting() => const MCPServerStatus(state: MCPServerState.starting);
  factory MCPServerStatus.running({List<MCPToolInfo>? tools}) => 
      MCPServerStatus(state: MCPServerState.running, tools: tools ?? []);
  factory MCPServerStatus.stopping() => const MCPServerStatus(state: MCPServerState.stopping);
  factory MCPServerStatus.error(String error) => 
      MCPServerStatus(state: MCPServerState.idle, error: error);
}

/// MCP 工具信息
@freezed
class MCPToolInfo with _$MCPToolInfo {
  const factory MCPToolInfo({
    required String name,
    String? description,
    Map<String, dynamic>? inputSchema,
  }) = _MCPToolInfo;

  factory MCPToolInfo.fromJson(Map<String, dynamic> json) =>
      _$MCPToolInfoFromJson(json);
}
