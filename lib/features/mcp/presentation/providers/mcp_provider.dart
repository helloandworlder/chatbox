import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mcp_client/mcp_client.dart' as mcp;
import 'package:uuid/uuid.dart';

import '../../domain/mcp_config.dart';
import '../../../settings/presentation/providers/app_settings_provider.dart';

final _logger = Logger('McpProvider');

/// MCP 服务器配置列表 Provider
final mcpServersConfigProvider = StateNotifierProvider<McpServersConfigNotifier, List<MCPServerConfig>>((ref) {
  return McpServersConfigNotifier(ref);
});

class McpServersConfigNotifier extends StateNotifier<List<MCPServerConfig>> {
  final Ref _ref;
  
  McpServersConfigNotifier(this._ref) : super([]) {
    _loadFromSettings();
  }

  void _loadFromSettings() {
    final serversJson = _ref.read(appSettingsProvider).mcpServersJson;
    if (serversJson != null && serversJson.isNotEmpty) {
      try {
        final List<dynamic> serversList = jsonDecode(serversJson);
        state = serversList.map((json) => MCPServerConfig.fromJson(json)).toList();
      } catch (e) {
        _logger.warning('Failed to load MCP servers: $e');
      }
    }
  }

  Future<void> _saveToSettings() async {
    final serversJson = jsonEncode(state.map((s) => s.toJson()).toList());
    await _ref.read(appSettingsProvider.notifier).setMcpServersJson(serversJson);
  }

  Future<void> addServer(MCPServerConfig config) async {
    final newConfig = config.id.isEmpty 
        ? MCPServerConfig(
            id: const Uuid().v4(),
            name: config.name,
            enabled: config.enabled,
            transport: config.transport,
          )
        : config;
    state = [...state, newConfig];
    await _saveToSettings();
  }

  Future<void> updateServer(MCPServerConfig config) async {
    state = [
      for (final server in state)
        if (server.id == config.id) config else server
    ];
    await _saveToSettings();
  }

  Future<void> removeServer(String serverId) async {
    state = state.where((s) => s.id != serverId).toList();
    await _saveToSettings();
  }

  Future<void> toggleServer(String serverId) async {
    final server = state.firstWhere((s) => s.id == serverId);
    await updateServer(server.copyWith(enabled: !server.enabled));
  }
}

/// MCP 服务器状态 Provider
final mcpServerStatusProvider = StateNotifierProvider.family<McpServerStatusNotifier, MCPServerStatus, String>((ref, serverId) {
  return McpServerStatusNotifier(ref, serverId);
});

class McpServerStatusNotifier extends StateNotifier<MCPServerStatus> {
  mcp.Client? _client;
  
  McpServerStatusNotifier(Ref ref, String serverId) : super(MCPServerStatus.idle());

  mcp.Client? get client => _client;

  Future<void> start(MCPServerConfig config) async {
    if (state.state == MCPServerState.running) return;

    state = MCPServerStatus.starting();

    try {
      // Create transport config based on transport type
      final transportConfig = _createTransportConfig(config.transport);
      
      // Create client config
      final clientConfig = mcp.McpClient.simpleConfig(
        name: 'chatbox_flutter',
        version: '2.0.0',
        enableDebugLogging: false,
      );

      // Create and connect
      final result = await mcp.McpClient.createAndConnect(
        config: clientConfig,
        transportConfig: transportConfig,
      );

      _client = result.fold(
        (client) => client,
        (error) => throw Exception('Failed to connect: $error'),
      );

      // Fetch tools
      final tools = await _client!.listTools();
      final toolInfos = tools.map((t) => MCPToolInfo(
        name: t.name,
        description: t.description,
        inputSchema: t.inputSchema,
      )).toList();

      state = MCPServerStatus.running(tools: toolInfos);
      _logger.info('MCP server ${config.name} started with ${toolInfos.length} tools');
    } catch (e) {
      _logger.severe('Failed to start MCP server ${config.name}: $e');
      state = MCPServerStatus.error(e.toString());
      _client = null;
    }
  }

  mcp.TransportConfig _createTransportConfig(MCPTransportConfig config) {
    return switch (config) {
      MCPStdioTransportConfig(:final command, :final args, :final env) =>
        mcp.TransportConfig.stdio(
          command: command,
          arguments: args,
          environment: env,
        ),
      MCPHttpTransportConfig(:final url, :final headers) =>
        mcp.TransportConfig.streamableHttp(
          baseUrl: url,
          headers: headers,
        ),
      MCPSseTransportConfig(:final url, :final headers) =>
        mcp.TransportConfig.sse(
          serverUrl: url,
          headers: headers,
        ),
    };
  }

  Future<void> stop() async {
    if (state.state != MCPServerState.running) return;

    state = MCPServerStatus.stopping();

    try {
      _client?.disconnect();
      _client = null;
      state = MCPServerStatus.idle();
    } catch (e) {
      _logger.warning('Error stopping MCP server: $e');
      state = MCPServerStatus.idle();
    }
  }

  Future<String> callTool(String toolName, Map<String, dynamic> arguments) async {
    if (_client == null || state.state != MCPServerState.running) {
      throw Exception('MCP server is not running');
    }

    final result = await _client!.callTool(toolName, arguments);
    
    final textContents = <String>[];
    for (final content in result.content) {
      if (content is mcp.TextContent) {
        textContents.add(content.text);
      }
    }
    
    return textContents.join('\n');
  }

  @override
  void dispose() {
    _client?.disconnect();
    super.dispose();
  }
}

/// MCP Actions Provider
final mcpActionsProvider = Provider<McpActions>((ref) {
  return McpActions(ref);
});

class McpActions {
  final Ref _ref;

  McpActions(this._ref);

  Future<void> bootstrapEnabledServers() async {
    final servers = _ref.read(mcpServersConfigProvider);
    for (final server in servers) {
      if (server.enabled) {
        await startServer(server.id);
      }
    }
  }

  Future<void> startServer(String serverId) async {
    final servers = _ref.read(mcpServersConfigProvider);
    final server = servers.firstWhere((s) => s.id == serverId);
    await _ref.read(mcpServerStatusProvider(serverId).notifier).start(server);
  }

  Future<void> stopServer(String serverId) async {
    await _ref.read(mcpServerStatusProvider(serverId).notifier).stop();
  }

  Future<void> restartServer(String serverId) async {
    await stopServer(serverId);
    await startServer(serverId);
  }

  Future<void> toggleServer(String serverId) async {
    await _ref.read(mcpServersConfigProvider.notifier).toggleServer(serverId);
    final servers = _ref.read(mcpServersConfigProvider);
    final server = servers.firstWhere((s) => s.id == serverId);
    if (server.enabled) {
      await startServer(serverId);
    } else {
      await stopServer(serverId);
    }
  }

  Future<void> addServer(MCPServerConfig config) async {
    await _ref.read(mcpServersConfigProvider.notifier).addServer(config);
    if (config.enabled) {
      // Find the newly added server (it will have an ID now)
      final servers = _ref.read(mcpServersConfigProvider);
      final newServer = servers.last;
      await startServer(newServer.id);
    }
  }

  Future<void> updateServer(MCPServerConfig config) async {
    await stopServer(config.id);
    await _ref.read(mcpServersConfigProvider.notifier).updateServer(config);
    if (config.enabled) {
      await startServer(config.id);
    }
  }

  Future<void> deleteServer(String serverId) async {
    await stopServer(serverId);
    await _ref.read(mcpServersConfigProvider.notifier).removeServer(serverId);
  }

  Future<String> callTool(String toolName, Map<String, dynamic> arguments) async {
    // Find the server that has this tool
    final servers = _ref.read(mcpServersConfigProvider);
    for (final server in servers) {
      if (!server.enabled) continue;
      
      final status = _ref.read(mcpServerStatusProvider(server.id));
      if (status.state != MCPServerState.running) continue;
      
      final hasTool = status.tools.any((t) => t.name == toolName);
      if (!hasTool) continue;

      return await _ref.read(mcpServerStatusProvider(server.id).notifier).callTool(toolName, arguments);
    }
    
    throw Exception('Tool "$toolName" not found in any running MCP server');
  }
}

/// MCP 服务器状态汇总 Provider
final mcpStatusesProvider = Provider<AsyncValue<Map<String, MCPServerStatus>>>((ref) {
  final servers = ref.watch(mcpServersConfigProvider);
  final statuses = <String, MCPServerStatus>{};
  
  for (final server in servers) {
    statuses[server.id] = ref.watch(mcpServerStatusProvider(server.id));
  }
  
  return AsyncValue.data(statuses);
});

/// MCP 服务器列表 (AsyncValue 包装)
final mcpServersProvider = Provider<AsyncValue<List<MCPServerConfig>>>((ref) {
  return AsyncValue.data(ref.watch(mcpServersConfigProvider));
});

/// 是否有正在运行的 MCP 服务器
final hasRunningMcpServersProvider = Provider<bool>((ref) {
  final statuses = ref.watch(mcpStatusesProvider).valueOrNull ?? {};
  return statuses.values.any((s) => s.state == MCPServerState.running);
});

/// 所有已连接的 MCP 工具
final mcpToolsProvider = Provider<List<MCPToolInfo>>((ref) {
  final statuses = ref.watch(mcpStatusesProvider).valueOrNull ?? {};
  final tools = <MCPToolInfo>[];
  for (final status in statuses.values) {
    if (status.state == MCPServerState.running) {
      tools.addAll(status.tools);
    }
  }
  return tools;
});
