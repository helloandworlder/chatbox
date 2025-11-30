import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/storage/database/app_database.dart';
import '../../../ai_models/presentation/providers/ai_provider.dart';
import '../../data/embedding_service.dart';
import '../providers/knowledge_base_provider.dart';
import '../widgets/knowledge_base_card.dart';

class KnowledgeBaseListPage extends ConsumerWidget {
  const KnowledgeBaseListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final knowledgeBases = ref.watch(knowledgeBasesProvider);
    final embeddingConfig = ref.watch(embeddingConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Bases'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Embedding Settings',
            onPressed: () => _showEmbeddingSettings(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: embeddingConfig != null && embeddingConfig.apiKey.isNotEmpty
                ? () => _showCreateDialog(context, ref)
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please configure embedding settings first'),
                      ),
                    );
                    _showEmbeddingSettings(context, ref);
                  },
          ),
        ],
      ),
      body: knowledgeBases.when(
        data: (kbs) {
          if (kbs.isEmpty) {
            return _buildEmptyState(context, ref, embeddingConfig);
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: kbs.length,
            itemBuilder: (context, index) {
              final kb = kbs[index];
              return KnowledgeBaseCard(
                knowledgeBase: kb,
                onTap: () => context.push('/knowledge-base/${kb.id}'),
                onDelete: () => _confirmDelete(context, ref, kb),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text('Error: $e'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.refresh(knowledgeBasesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    WidgetRef ref,
    EmbeddingModelConfig? embeddingConfig,
  ) {
    final isConfigured =
        embeddingConfig != null && embeddingConfig.apiKey.isNotEmpty;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_special_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Knowledge Bases',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            isConfigured
                ? 'Create a knowledge base to enable RAG'
                : 'Configure embedding settings first',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          if (!isConfigured)
            FilledButton.icon(
              onPressed: () => _showEmbeddingSettings(context, ref),
              icon: const Icon(Icons.settings),
              label: const Text('Configure Embedding'),
            )
          else
            FilledButton.icon(
              onPressed: () => _showCreateDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Create Knowledge Base'),
            ),
        ],
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Knowledge Base'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'My Knowledge Base',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name is required')),
                );
                return;
              }

              final id = await ref.read(knowledgeBaseActionsProvider).createKnowledgeBase(
                    name: name,
                    description: descController.text.trim().isNotEmpty
                        ? descController.text.trim()
                        : null,
                  );

              if (context.mounted) {
                Navigator.pop(context);
                context.push('/knowledge-base/$id');
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    KnowledgeBase kb,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Knowledge Base'),
        content: Text(
          'Are you sure you want to delete "${kb.name}"?\n\n'
          'This will delete all files and indexed data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(knowledgeBaseActionsProvider)
                  .deleteKnowledgeBase(kb.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Deleted "${kb.name}"')),
                );
              }
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

  void _showEmbeddingSettings(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _EmbeddingSettingsSheet(),
    );
  }
}

class _EmbeddingSettingsSheet extends ConsumerStatefulWidget {
  const _EmbeddingSettingsSheet();

  @override
  ConsumerState<_EmbeddingSettingsSheet> createState() =>
      _EmbeddingSettingsSheetState();
}

class _EmbeddingSettingsSheetState
    extends ConsumerState<_EmbeddingSettingsSheet> {
  late final TextEditingController _apiKeyController;
  late final TextEditingController _baseUrlController;
  late final TextEditingController _modelController;
  String _dimensions = '1536';

  @override
  void initState() {
    super.initState();
    final config = ref.read(embeddingConfigProvider);
    _apiKeyController = TextEditingController(text: config?.apiKey ?? '');
    _baseUrlController = TextEditingController(
        text: config?.baseUrl ?? 'https://api.openai.com/v1');
    _modelController =
        TextEditingController(text: config?.model ?? 'text-embedding-3-small');
    _dimensions = (config?.dimensions ?? 1536).toString();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providers = ref.watch(aiProvidersProvider);

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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Embedding Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Configure the embedding model used for knowledge base indexing and search.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),

              // Quick setup from AI Provider
              if (providers.isNotEmpty) ...[
                Text(
                  'Quick Setup from AI Provider',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: providers
                      .where((p) =>
                          p.enabled && p.apiKey != null && p.apiKey!.isNotEmpty)
                      .map((p) => ActionChip(
                            label: Text(p.name),
                            onPressed: () async {
                              await ref
                                  .read(embeddingConfigProvider.notifier)
                                  .setFromAIProvider(p.id);
                              final config = ref.read(embeddingConfigProvider);
                              if (config != null) {
                                _apiKeyController.text = config.apiKey;
                                _baseUrlController.text = config.baseUrl;
                                _modelController.text = config.model;
                                setState(() {
                                  _dimensions = config.dimensions.toString();
                                });
                              }
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
              ],

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
                  labelText: 'Base URL',
                  hintText: 'https://api.openai.com/v1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Model',
                  hintText: 'text-embedding-3-small',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _dimensions,
                decoration: const InputDecoration(
                  labelText: 'Dimensions',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: '768', child: Text('768 (Ollama)')),
                  DropdownMenuItem(
                      value: '1536', child: Text('1536 (OpenAI small)')),
                  DropdownMenuItem(
                      value: '3072', child: Text('3072 (OpenAI large)')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _dimensions = value;
                    });
                  }
                },
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
                    onPressed: _save,
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

  Future<void> _save() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API Key is required')),
      );
      return;
    }

    await ref.read(embeddingConfigProvider.notifier).setConfig(
          EmbeddingModelConfig(
            providerId: 'custom',
            model: _modelController.text.trim(),
            baseUrl: _baseUrlController.text.trim(),
            apiKey: apiKey,
            dimensions: int.tryParse(_dimensions) ?? 1536,
          ),
        );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Embedding settings saved')),
      );
    }
  }
}
