import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/provider_config.dart';
import '../providers/ai_provider.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _EditProviderSheet(
        provider: provider,
        onSave: (config) {
          ref.read(aiProvidersProvider.notifier).updateProvider(config);
          Navigator.pop(context);
        },
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
    // 显示加载对话框
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
        Navigator.pop(context); // 关闭加载对话框
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Found ${models.length} models')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // 关闭加载对话框
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

class _AddProviderSheet extends StatefulWidget {
  final ValueChanged<AIProviderConfig> onAdd;

  const _AddProviderSheet({required this.onAdd});

  @override
  State<_AddProviderSheet> createState() => _AddProviderSheetState();
}

class _AddProviderSheetState extends State<_AddProviderSheet> {
  AIProviderType _selectedType = AIProviderType.openai;
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
                'Add AI Provider',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AIProviderType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Provider Type',
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
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                  labelText: 'Base URL (optional)',
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
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _submit,
                    child: const Text('Add'),
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
        const SnackBar(content: Text('Please enter a name')),
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
    ));
  }

  String _getTypeName(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => 'OpenAI',
      AIProviderType.claude => 'Anthropic (Claude)',
      AIProviderType.gemini => 'Google (Gemini)',
      AIProviderType.deepseek => 'DeepSeek',
      AIProviderType.openrouter => 'OpenRouter',
      AIProviderType.ollama => 'Ollama (Local)',
      AIProviderType.azure => 'Azure OpenAI',
      AIProviderType.custom => 'Custom (OpenAI Compatible)',
    };
  }

  String? _getDefaultBaseUrl(AIProviderType type) {
    return providerDefaultBaseUrls[type];
  }
}

class _EditProviderSheet extends StatefulWidget {
  final AIProviderConfig provider;
  final ValueChanged<AIProviderConfig> onSave;

  const _EditProviderSheet({
    required this.provider,
    required this.onSave,
  });

  @override
  State<_EditProviderSheet> createState() => _EditProviderSheetState();
}

class _EditProviderSheetState extends State<_EditProviderSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _apiKeyController;
  late final TextEditingController _baseUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.provider.name);
    _apiKeyController = TextEditingController(text: widget.provider.apiKey ?? '');
    _baseUrlController = TextEditingController(text: widget.provider.baseUrl ?? '');
  }

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
                'Edit ${widget.provider.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                decoration: const InputDecoration(
                  labelText: 'Base URL (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _submit,
                    child: const Text('Save'),
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
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    widget.onSave(widget.provider.copyWith(
      name: name,
      apiKey: apiKey.isNotEmpty ? apiKey : null,
      baseUrl: _baseUrlController.text.trim().isNotEmpty
          ? _baseUrlController.text.trim()
          : null,
    ));
  }
}
