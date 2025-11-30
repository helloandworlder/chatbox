import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/mcp_config.dart';
import '../providers/mcp_provider.dart';
import 'mcp_status.dart';

/// MCP 服务器卡片
class MCPServerCard extends ConsumerWidget {
  final MCPServerConfig config;

  const MCPServerCard({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(mcpServerStatusProvider(config.id));
    final actions = ref.read(mcpActionsProvider);

    return Card(
      child: ListTile(
        leading: MCPStatusIndicator(status: status, size: 10),
        title: Text(config.name),
        subtitle: Text(_getTransportDescription()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 工具数量
            if (status.state == MCPServerState.running && status.tools.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text('${status.tools.length} tools'),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            // 启用开关
            Switch(
              value: config.enabled,
              onChanged: (_) => actions.toggleServer(config.id),
            ),
            // 更多操作
            PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(context, ref, value),
              itemBuilder: (context) => [
                if (config.enabled && status.state == MCPServerState.running)
                  const PopupMenuItem(
                    value: 'restart',
                    child: ListTile(
                      leading: Icon(Icons.refresh),
                      title: Text('Restart'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Delete', style: TextStyle(color: Colors.red)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _showToolsDialog(context, status),
      ),
    );
  }

  String _getTransportDescription() {
    return switch (config.transport) {
      MCPStdioTransportConfig(:final command, :final args) =>
        'STDIO: $command ${args.join(' ')}',
      MCPHttpTransportConfig(:final url) => 'HTTP: $url',
      MCPSseTransportConfig(:final url) => 'SSE: $url',
    };
  }

  void _handleMenuAction(BuildContext context, WidgetRef ref, String action) {
    final actions = ref.read(mcpActionsProvider);
    switch (action) {
      case 'restart':
        actions.restartServer(config.id);
        break;
      case 'edit':
        _showEditDialog(context, ref);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref);
        break;
    }
  }

  void _showToolsDialog(BuildContext context, MCPServerStatus status) {
    if (status.tools.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${config.name} Tools'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: status.tools.length,
            itemBuilder: (context, index) {
              final tool = status.tools[index];
              return ListTile(
                title: Text(tool.name),
                subtitle: tool.description != null
                    ? Text(tool.description!, maxLines: 2, overflow: TextOverflow.ellipsis)
                    : null,
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => MCPConfigDialog(
        existingConfig: config,
        onSave: (updatedConfig) {
          ref.read(mcpActionsProvider).updateServer(updatedConfig);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Server'),
        content: Text('Are you sure you want to delete "${config.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(mcpActionsProvider).deleteServer(config.id);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// MCP 服务器配置对话框
class MCPConfigDialog extends StatefulWidget {
  final MCPServerConfig? existingConfig;
  final void Function(MCPServerConfig config) onSave;

  const MCPConfigDialog({
    super.key,
    this.existingConfig,
    required this.onSave,
  });

  @override
  State<MCPConfigDialog> createState() => _MCPConfigDialogState();
}

class _MCPConfigDialogState extends State<MCPConfigDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _commandController;
  late final TextEditingController _argsController;
  late final TextEditingController _urlController;
  
  String _transportType = 'http';
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    final config = widget.existingConfig;
    _nameController = TextEditingController(text: config?.name ?? '');
    _enabled = config?.enabled ?? false;

    if (config != null) {
      switch (config.transport) {
        case MCPStdioTransportConfig(:final command, :final args):
          _transportType = 'stdio';
          _commandController = TextEditingController(text: command);
          _argsController = TextEditingController(text: args.join(' '));
          _urlController = TextEditingController();
          break;
        case MCPHttpTransportConfig(:final url):
          _transportType = 'http';
          _urlController = TextEditingController(text: url);
          _commandController = TextEditingController();
          _argsController = TextEditingController();
          break;
        case MCPSseTransportConfig(:final url):
          _transportType = 'sse';
          _urlController = TextEditingController(text: url);
          _commandController = TextEditingController();
          _argsController = TextEditingController();
          break;
      }
    } else {
      _commandController = TextEditingController();
      _argsController = TextEditingController();
      _urlController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commandController.dispose();
    _argsController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingConfig == null ? 'Add MCP Server' : 'Edit MCP Server'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Server Name',
                hintText: 'My MCP Server',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _transportType,
              decoration: const InputDecoration(labelText: 'Transport Type'),
              items: const [
                DropdownMenuItem(value: 'http', child: Text('HTTP')),
                DropdownMenuItem(value: 'sse', child: Text('SSE')),
                DropdownMenuItem(value: 'stdio', child: Text('STDIO (Desktop only)')),
              ],
              onChanged: (value) => setState(() => _transportType = value!),
            ),
            const SizedBox(height: 16),
            if (_transportType == 'stdio') ...[
              TextField(
                controller: _commandController,
                decoration: const InputDecoration(
                  labelText: 'Command',
                  hintText: 'npx',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _argsController,
                decoration: const InputDecoration(
                  labelText: 'Arguments',
                  hintText: '-y @modelcontextprotocol/server-filesystem /path',
                ),
              ),
            ] else ...[
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  hintText: _transportType == 'http'
                      ? 'https://mcp-server.example.com'
                      : 'https://mcp-server.example.com/sse',
                ),
              ),
            ],
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable on save'),
              value: _enabled,
              onChanged: (value) => setState(() => _enabled = value),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a server name')),
      );
      return;
    }

    MCPTransportConfig transport;
    switch (_transportType) {
      case 'stdio':
        final command = _commandController.text.trim();
        if (command.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a command')),
          );
          return;
        }
        final args = _argsController.text.trim().split(' ').where((s) => s.isNotEmpty).toList();
        transport = MCPTransportConfig.stdio(command: command, args: args);
        break;
      case 'sse':
        final url = _urlController.text.trim();
        if (url.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a URL')),
          );
          return;
        }
        transport = MCPTransportConfig.sse(url: url);
        break;
      default:
        final url = _urlController.text.trim();
        if (url.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a URL')),
          );
          return;
        }
        transport = MCPTransportConfig.http(url: url);
    }

    final config = MCPServerConfig(
      id: widget.existingConfig?.id ?? '',
      name: name,
      enabled: _enabled,
      transport: transport,
    );

    widget.onSave(config);
  }
}
