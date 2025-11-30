import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/provider_config.dart';
import '../providers/ai_provider.dart';
import '../widgets/model_edit_dialog.dart';

class ProviderSettingsPage extends ConsumerWidget {
  const ProviderSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(aiProvidersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Providers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddProviderDialog(context, ref),
          ),
        ],
      ),
      body: providers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text('No AI providers configured'),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => _showAddProviderDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Provider'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                final provider = providers[index];
                return _ProviderTile(
                  provider: provider,
                  onTap: () => _showEditProviderDialog(context, ref, provider),
                  onToggle: (enabled) {
                    ref.read(aiProvidersProvider.notifier).updateProvider(
                          provider.copyWith(enabled: enabled),
                        );
                  },
                  onDelete: () => _confirmDelete(context, ref, provider),
                  onRefreshModels: () => _refreshModels(context, ref, provider),
                );
              },
            ),
    );
  }

  void _showAddProviderDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddProviderSheet(
        onAdd: (config) {
          ref.read(aiProvidersProvider.notifier).addProvider(config);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditProviderDialog(
    BuildContext context,
    WidgetRef ref,
    AIProviderConfig provider,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ProviderDetailPage(provider: provider),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AIProviderConfig provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Provider'),
        content: Text('Are you sure you want to delete "${provider.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(aiProvidersProvider.notifier).removeProvider(provider.id);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshModels(
    BuildContext context,
    WidgetRef ref,
    AIProviderConfig provider,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Fetching models...'),
          ],
        ),
      ),
    );

    try {
      final models = await ref
          .read(aiProvidersProvider.notifier)
          .refreshModels(provider.id);

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Found ${models.length} models')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch models: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _ProviderTile extends StatelessWidget {
  final AIProviderConfig provider;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onRefreshModels;

  const _ProviderTile({
    required this.provider,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
    required this.onRefreshModels,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getProviderIcon(provider.type),
      title: Text(provider.name),
      subtitle: Text(
        provider.apiKey != null && provider.apiKey!.isNotEmpty
            ? '${provider.models.length} models | API Key: ${_maskApiKey(provider.apiKey!)}'
            : 'No API key set',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh models',
            onPressed: provider.apiKey?.isNotEmpty == true ? onRefreshModels : null,
          ),
          Switch(
            value: provider.enabled,
            onChanged: provider.apiKey?.isNotEmpty == true ? onToggle : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _getProviderIcon(AIProviderType type) {
    final icon = switch (type) {
      AIProviderType.openai => Icons.auto_awesome,
      AIProviderType.claude => Icons.psychology,
      AIProviderType.gemini => Icons.diamond,
      AIProviderType.deepseek => Icons.water_drop,
      AIProviderType.openrouter => Icons.router,
      AIProviderType.ollama => Icons.computer,
      AIProviderType.azure => Icons.cloud,
      AIProviderType.custom => Icons.settings,
    };
    return Icon(icon);
  }

  String _maskApiKey(String key) {
    if (key.length <= 8) return '****';
    return '${key.substring(0, 4)}...${key.substring(key.length - 4)}';
  }
}

// ========== Provider Detail Page ==========

class _ProviderDetailPage extends ConsumerStatefulWidget {
  final AIProviderConfig provider;

  const _ProviderDetailPage({required this.provider});

  @override
  ConsumerState<_ProviderDetailPage> createState() => _ProviderDetailPageState();
}

class _ProviderDetailPageState extends ConsumerState<_ProviderDetailPage> {
  late TextEditingController _nameController;
  late TextEditingController _apiKeyController;
  late TextEditingController _baseUrlController;
  late TextEditingController _apiPathController;
  late APIProtocolType _apiProtocol;
  
  bool _isTesting = false;
  String? _testResult;
  bool? _testSuccess;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.provider.name);
    _apiKeyController = TextEditingController(text: widget.provider.apiKey ?? '');
    _baseUrlController = TextEditingController(text: widget.provider.baseUrl ?? '');
    _apiPathController = TextEditingController(text: widget.provider.apiPath ?? '');
    _apiProtocol = widget.provider.apiProtocol;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    _apiPathController.dispose();
    super.dispose();
  }

  AIProviderConfig get _currentProvider {
    final providers = ref.read(aiProvidersProvider);
    return providers.firstWhere(
      (p) => p.id == widget.provider.id,
      orElse: () => widget.provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(aiProvidersProvider).firstWhere(
          (p) => p.id == widget.provider.id,
          orElse: () => widget.provider,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 基本信息
          _buildSectionTitle('基本设置'),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '名称',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _saveProvider(),
          ),
          const SizedBox(height: 16),

          // API 协议类型 (仅 custom 类型显示)
          if (provider.type == AIProviderType.custom) ...[
            DropdownButtonFormField<APIProtocolType>(
              value: _apiProtocol,
              decoration: const InputDecoration(
                labelText: 'API 协议',
                border: OutlineInputBorder(),
              ),
              items: APIProtocolType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_getProtocolName(type)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _apiProtocol = value);
                  _saveProvider();
                }
              },
            ),
            const SizedBox(height: 16),
          ],

          TextField(
            controller: _apiKeyController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'API Key',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: _isTesting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                tooltip: '测试连接',
                onPressed: _isTesting ? null : _testConnection,
              ),
            ),
            onChanged: (_) => _saveProvider(),
          ),

          // 测试结果
          if (_testResult != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _testSuccess == true
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _testSuccess == true ? Colors.green : Colors.red,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _testSuccess == true ? Icons.check_circle : Icons.error,
                    color: _testSuccess == true ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(_testResult!)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),

          TextField(
            controller: _baseUrlController,
            decoration: InputDecoration(
              labelText: 'API 主机',
              hintText: providerDefaultBaseUrls[provider.type] ?? 'https://api.example.com/v1',
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) => _saveProvider(),
          ),
          const SizedBox(height: 16),

          if (provider.type == AIProviderType.custom) ...[
            TextField(
              controller: _apiPathController,
              decoration: const InputDecoration(
                labelText: 'API 路径 (可选)',
                hintText: '/chat/completions',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _saveProvider(),
            ),
            const SizedBox(height: 16),
          ],

          const Divider(),
          const SizedBox(height: 16),

          // 模型管理
          _buildSectionTitle('模型'),
          const SizedBox(height: 8),

          // 模型操作按钮
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _addModel(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('新建'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => _resetModels(context),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('重置'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: provider.apiKey?.isNotEmpty == true
                    ? () => _fetchModels(context)
                    : null,
                icon: const Icon(Icons.cloud_download, size: 18),
                label: const Text('获取'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 模型列表
          if (provider.models.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  '没有可用模型',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ...provider.models.map((model) => _ModelCard(
                  model: model,
                  onEdit: () => _editModel(context, model),
                  onDelete: () => _deleteModel(model),
                )),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  String _getProtocolName(APIProtocolType type) {
    return switch (type) {
      APIProtocolType.openai => 'OpenAI API 兼容',
      APIProtocolType.claude => 'Anthropic Message API',
      APIProtocolType.gemini => 'Google Gemini API',
    };
  }

  void _saveProvider() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final apiKey = _apiKeyController.text.trim();
    final baseUrl = _baseUrlController.text.trim();
    final apiPath = _apiPathController.text.trim();

    ref.read(aiProvidersProvider.notifier).updateProvider(
          _currentProvider.copyWith(
            name: name,
            apiKey: apiKey.isNotEmpty ? apiKey : null,
            baseUrl: baseUrl.isNotEmpty ? baseUrl : null,
            apiPath: apiPath.isNotEmpty ? apiPath : null,
            apiProtocol: _apiProtocol,
          ),
        );
  }

  Future<void> _testConnection() async {
    setState(() {
      _isTesting = true;
      _testResult = null;
      _testSuccess = null;
    });

    try {
      final models = await ref
          .read(aiProvidersProvider.notifier)
          .refreshModels(widget.provider.id);

      setState(() {
        _isTesting = false;
        _testSuccess = true;
        _testResult = '连接成功！找到 ${models.length} 个模型';
      });
    } catch (e) {
      setState(() {
        _isTesting = false;
        _testSuccess = false;
        _testResult = '连接失败：${e.toString()}';
      });
    }
  }

  void _addModel(BuildContext context) {
    showModelEditDialog(
      context: context,
      onSave: (model) {
        ref.read(aiProvidersProvider.notifier).addModel(widget.provider.id, model);
      },
    );
  }

  void _editModel(BuildContext context, ModelConfig model) {
    showModelEditDialog(
      context: context,
      model: model,
      onSave: (updatedModel) {
        ref.read(aiProvidersProvider.notifier).updateModel(
              widget.provider.id,
              updatedModel,
            );
      },
    );
  }

  void _deleteModel(ModelConfig model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除模型'),
        content: Text('确定要删除模型 "${model.displayName}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(aiProvidersProvider.notifier).removeModel(
                    widget.provider.id,
                    model.id,
                  );
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetModels(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置模型'),
        content: const Text('确定要将模型列表重置为默认值吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('重置'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(aiProvidersProvider.notifier).resetModels(widget.provider.id);
    }
  }

  Future<void> _fetchModels(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('正在获取模型...'),
          ],
        ),
      ),
    );

    try {
      final models = await ref
          .read(aiProvidersProvider.notifier)
          .refreshModels(widget.provider.id);

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('找到 ${models.length} 个模型')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('获取失败：${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除提供商'),
        content: Text('确定要删除 "${widget.provider.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(aiProvidersProvider.notifier).removeProvider(widget.provider.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

// ========== Model Card ==========

class _ModelCard extends StatelessWidget {
  final ModelConfig model;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ModelCard({
    required this.model,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(model.displayName),
        subtitle: Row(
          children: [
            if (model.supportsVision)
              _buildCapabilityChip(context, Icons.visibility, '视觉'),
            if (model.supportsReasoning)
              _buildCapabilityChip(context, Icons.psychology, '推理'),
            if (model.supportsFunctionCalling)
              _buildCapabilityChip(context, Icons.build, '工具'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapabilityChip(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ========== Add Provider Sheet ==========

class _AddProviderSheet extends StatefulWidget {
  final ValueChanged<AIProviderConfig> onAdd;

  const _AddProviderSheet({required this.onAdd});

  @override
  State<_AddProviderSheet> createState() => _AddProviderSheetState();
}

class _AddProviderSheetState extends State<_AddProviderSheet> {
  AIProviderType _selectedType = AIProviderType.openai;
  APIProtocolType _apiProtocol = APIProtocolType.openai;
  final _nameController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final _baseUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '添加 AI Provider',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AIProviderType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Provider 类型',
                  border: OutlineInputBorder(),
                ),
                items: AIProviderType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeName(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                      if (_nameController.text.isEmpty) {
                        _nameController.text = _getTypeName(value);
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              if (_selectedType == AIProviderType.custom) ...[
                DropdownButtonFormField<APIProtocolType>(
                  value: _apiProtocol,
                  decoration: const InputDecoration(
                    labelText: 'API 协议',
                    border: OutlineInputBorder(),
                  ),
                  items: APIProtocolType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_getProtocolName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _apiProtocol = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '名称',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _apiKeyController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _baseUrlController,
                decoration: InputDecoration(
                  labelText: 'Base URL (可选)',
                  hintText: _getDefaultBaseUrl(_selectedType),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _submit,
                    child: const Text('添加'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    final apiKey = _apiKeyController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入名称')),
      );
      return;
    }

    widget.onAdd(AIProviderConfig(
      id: const Uuid().v4(),
      type: _selectedType,
      name: name,
      apiKey: apiKey.isNotEmpty ? apiKey : null,
      baseUrl: _baseUrlController.text.trim().isNotEmpty
          ? _baseUrlController.text.trim()
          : null,
      apiProtocol: _apiProtocol,
    ));
  }

  String _getTypeName(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => 'OpenAI',
      AIProviderType.claude => 'Anthropic (Claude)',
      AIProviderType.gemini => 'Google (Gemini)',
      AIProviderType.deepseek => 'DeepSeek',
      AIProviderType.openrouter => 'OpenRouter',
      AIProviderType.ollama => 'Ollama (本地)',
      AIProviderType.azure => 'Azure OpenAI',
      AIProviderType.custom => '自定义 (兼容 API)',
    };
  }

  String _getProtocolName(APIProtocolType type) {
    return switch (type) {
      APIProtocolType.openai => 'OpenAI API 兼容',
      APIProtocolType.claude => 'Anthropic Message API',
      APIProtocolType.gemini => 'Google Gemini API',
    };
  }

  String? _getDefaultBaseUrl(AIProviderType type) {
    return providerDefaultBaseUrls[type];
  }
}
