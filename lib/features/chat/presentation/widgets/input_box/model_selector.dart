import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ai_models/presentation/providers/ai_provider.dart';
import '../../../../ai_models/domain/provider_config.dart';

class ModelSelector extends ConsumerWidget {
  const ModelSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(aiProvidersProvider);
    final currentProviderId = ref.watch(currentProviderIdProvider);
    final currentModelId = ref.watch(currentModelIdProvider);
    final hasProvider = ref.watch(hasConfiguredProviderProvider);

    if (!hasProvider) {
      return TextButton.icon(
        onPressed: () => _showProviderSetupDialog(context, ref),
        icon: const Icon(Icons.warning_amber, size: 18),
        label: const Text('Configure AI'),
      );
    }

    final currentProvider = providers
        .where((p) => p.id == currentProviderId)
        .firstOrNull;
    final currentModel = currentProvider?.models
        .where((m) => m.id == currentModelId)
        .firstOrNull;

    return TextButton.icon(
      onPressed: () => _showModelPicker(context, ref, providers),
      icon: const Icon(Icons.auto_awesome, size: 18),
      label: Text(currentModel?.name ?? 'Select Model'),
    );
  }

  void _showModelPicker(
    BuildContext context,
    WidgetRef ref,
    List<AIProviderConfig> providers,
  ) {
    final enabledProviders = providers.where((p) => p.enabled).toList();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Model',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: enabledProviders.length,
                itemBuilder: (context, providerIndex) {
                  final provider = enabledProviders[providerIndex];
                  return ExpansionTile(
                    leading: _getProviderIcon(provider.type),
                    title: Text(provider.name),
                    initiallyExpanded: provider.id == ref.read(currentProviderIdProvider),
                    children: provider.models.map((model) {
                      final isSelected = 
                          provider.id == ref.read(currentProviderIdProvider) &&
                          model.id == ref.read(currentModelIdProvider);
                      return ListTile(
                        leading: isSelected 
                            ? const Icon(Icons.check, color: Colors.green)
                            : const SizedBox(width: 24),
                        title: Text(model.name),
                        subtitle: model.contextWindow != null
                            ? Text('Context: ${_formatNumber(model.contextWindow!)} tokens')
                            : null,
                        onTap: () {
                          ref.read(currentProviderIdProvider.notifier).state = provider.id;
                          ref.read(currentModelIdProvider.notifier).state = model.id;
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProviderSetupDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configure AI Provider'),
        content: const Text(
          'You need to configure at least one AI provider to start chatting. '
          'Go to Settings > AI Providers to add your API keys.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to settings
            },
            child: const Text('Go to Settings'),
          ),
        ],
      ),
    );
  }

  Widget _getProviderIcon(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => const Icon(Icons.auto_awesome),
      AIProviderType.claude => const Icon(Icons.psychology),
      AIProviderType.gemini => const Icon(Icons.diamond),
      AIProviderType.deepseek => const Icon(Icons.water_drop),
      AIProviderType.openrouter => const Icon(Icons.router),
      AIProviderType.ollama => const Icon(Icons.computer),
      AIProviderType.azure => const Icon(Icons.cloud),
      AIProviderType.custom => const Icon(Icons.settings),
    };
  }

  String _formatNumber(int n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(1)}M';
    } else if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(0)}K';
    }
    return n.toString();
  }
}
