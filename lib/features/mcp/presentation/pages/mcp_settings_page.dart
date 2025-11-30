import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/mcp_config.dart';
import '../providers/mcp_provider.dart';

class McpSettingsPage extends ConsumerStatefulWidget {
  const McpSettingsPage({super.key});

  @override
  ConsumerState<McpSettingsPage> createState() => _McpSettingsPageState();
}

class _McpSettingsPageState extends ConsumerState<McpSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final servers = ref.watch(mcpServersConfigProvider);
    final statuses = ref.watch(mcpStatusesProvider).valueOrNull ?? {};
    final tools = ref.watch(mcpToolsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MCP 服务器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(mcpActionsProvider).bootstrapEnabledServers();
            },
            tooltip: '重新连接所有',
          ),
        ],
      ),
      body: ListView(
        children: [
          // 工具统计
          if (tools.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.build, color: Colors.blue),
                      const SizedBox(width: 12),
                      Text(
                        '已加载 ${tools.length} 个工具',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 服务器列表
          if (servers.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  '尚未配置 MCP 服务器\n点击右下角添加',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...servers.map((server) {
              final status = statuses[server.id] ?? MCPServerStatus.idle();
              return _ServerCard(
                server: server,
                status: status,
                onEdit: () => _showEditDialog(server),
                onDelete: () => _confirmDelete(server),
                onToggle: () {
                  ref.read(mcpActionsProvider).toggleServer(server.id);
                },
              );
            }),

          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => _ServerEditDialog(
        onSave: (config) {
          ref.read(mcpActionsProvider).addServer(config);
        },
      ),
    );
  }

  void _showEditDialog(MCPServerConfig server) {
    showDialog(
      context: context,
      builder: (context) => _ServerEditDialog(
        server: server,
        onSave: (config) {
          ref.read(mcpActionsProvider).updateServer(config);
        },
      ),
    );
  }

  void _confirmDelete(MCPServerConfig server) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除服务器'),
        content: Text('确定要删除 "${server.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(mcpActionsProvider).deleteServer(server.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

class _ServerCard extends StatelessWidget {
  final MCPServerConfig server;
  final MCPServerStatus status;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _ServerCard({
    required this.server,
    required this.status,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: _buildStateIcon(),
            title: Text(server.name),
            subtitle: Text(
              _getTransportDescription(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status.state == MCPServerState.running && status.tools.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text('${status.tools.length} tools'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                Switch(
                  value: server.enabled,
                  onChanged: (_) => onToggle(),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onEdit();
                        break;
                      case 'delete':
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('编辑'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('删除', style: TextStyle(color: Colors.red)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 连接错误信息
          if (status.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.red.shade50,
              child: Text(
                '连接失败: ${status.error}',
                style: const TextStyle(color: Colors.red, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStateIcon() {
    switch (status.state) {
      case MCPServerState.running:
        return const Icon(Icons.check_circle, color: Colors.green);
      case MCPServerState.starting:
      case MCPServerState.stopping:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case MCPServerState.idle:
        if (status.error != null) {
          return const Icon(Icons.error, color: Colors.red);
        }
        return Icon(Icons.cloud_off, color: Colors.grey.shade400);
    }
  }

  String _getTransportDescription() {
    return switch (server.transport) {
      MCPSseTransportConfig(:final url) => 'SSE: $url',
      MCPHttpTransportConfig(:final url) => 'HTTP: $url',
      MCPStdioTransportConfig(:final command, :final args) => 
        'STDIO: $command ${args.join(' ')}',
    };
  }
}

class _ServerEditDialog extends StatefulWidget {
  final MCPServerConfig? server;
  final void Function(MCPServerConfig) onSave;

  const _ServerEditDialog({
    this.server,
    required this.onSave,
  });

  @override
  State<_ServerEditDialog> createState() => _ServerEditDialogState();
}

class _ServerEditDialogState extends State<_ServerEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _serverUrlController;
  late TextEditingController _commandController;
  late TextEditingController _argumentsController;

  String _transportType = 'sse';
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    final server = widget.server;
    _nameController = TextEditingController(text: server?.name ?? '');
    _enabled = server?.enabled ?? false;
    
    if (server != null) {
      switch (server.transport) {
        case MCPStdioTransportConfig(:final command, :final args):
          _transportType = 'stdio';
          _commandController = TextEditingController(text: command);
          _argumentsController = TextEditingController(text: args.join(' '));
          _serverUrlController = TextEditingController();
          break;
        case MCPHttpTransportConfig(:final url):
          _transportType = 'http';
          _serverUrlController = TextEditingController(text: url);
          _commandController = TextEditingController();
          _argumentsController = TextEditingController();
          break;
        case MCPSseTransportConfig(:final url):
          _transportType = 'sse';
          _serverUrlController = TextEditingController(text: url);
          _commandController = TextEditingController();
          _argumentsController = TextEditingController();
          break;
      }
    } else {
      _serverUrlController = TextEditingController();
      _commandController = TextEditingController();
      _argumentsController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serverUrlController.dispose();
    _commandController.dispose();
    _argumentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.server != null;

    return AlertDialog(
      title: Text(isEditing ? '编辑服务器' : '添加服务器'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '名称 *',
                    hintText: '例如: 文件系统工具',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入名称';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _transportType,
                  decoration: const InputDecoration(
                    labelText: '传输类型',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'sse',
                      child: Text('SSE (Server-Sent Events)'),
                    ),
                    DropdownMenuItem(
                      value: 'http',
                      child: Text('HTTP'),
                    ),
                    DropdownMenuItem(
                      value: 'stdio',
                      child: Text('STDIO (本地进程)'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _transportType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // HTTP/SSE 配置
                if (_transportType == 'sse' || _transportType == 'http') ...[
                  TextFormField(
                    controller: _serverUrlController,
                    decoration: InputDecoration(
                      labelText: '服务器 URL *',
                      hintText: _transportType == 'sse'
                          ? 'http://localhost:8999/sse'
                          : 'https://api.example.com',
                    ),
                    validator: (value) {
                      if (_transportType == 'sse' || _transportType == 'http') {
                        if (value == null || value.isEmpty) {
                          return '请输入服务器 URL';
                        }
                        final uri = Uri.tryParse(value);
                        if (uri == null || !uri.hasScheme) {
                          return '请输入有效的 URL';
                        }
                      }
                      return null;
                    },
                  ),
                ],

                // STDIO 配置
                if (_transportType == 'stdio') ...[
                  TextFormField(
                    controller: _commandController,
                    decoration: const InputDecoration(
                      labelText: '命令 *',
                      hintText: '例如: npx 或 python',
                    ),
                    validator: (value) {
                      if (_transportType == 'stdio') {
                        if (value == null || value.isEmpty) {
                          return '请输入命令';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _argumentsController,
                    decoration: const InputDecoration(
                      labelText: '参数 (空格分隔)',
                      hintText: '-y @modelcontextprotocol/server-filesystem /path',
                    ),
                    maxLines: 2,
                  ),
                ],

                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('启用'),
                  value: _enabled,
                  onChanged: (value) => setState(() => _enabled = value),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('保存'),
        ),
      ],
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    
    MCPTransportConfig transport;
    switch (_transportType) {
      case 'stdio':
        final command = _commandController.text.trim();
        final args = _argumentsController.text.trim().split(' ').where((s) => s.isNotEmpty).toList();
        transport = MCPTransportConfig.stdio(command: command, args: args);
        break;
      case 'http':
        final url = _serverUrlController.text.trim();
        transport = MCPTransportConfig.http(url: url);
        break;
      default:
        final url = _serverUrlController.text.trim();
        transport = MCPTransportConfig.sse(url: url);
    }

    final config = MCPServerConfig(
      id: widget.server?.id ?? '',
      name: name,
      enabled: _enabled,
      transport: transport,
    );

    widget.onSave(config);
    Navigator.pop(context);
  }
}
