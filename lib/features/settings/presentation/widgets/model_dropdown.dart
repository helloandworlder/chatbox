import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ai_models/domain/provider_config.dart';
import '../../../ai_models/presentation/providers/ai_provider.dart';

class ModelDropdown extends ConsumerWidget {
  final String? value;
  final String label;
  final String hint;
  final String autoLabel;
  final ValueChanged<String?> onChanged;
  final bool allowNull;

  const ModelDropdown({
    super.key,
    this.value,
    required this.label,
    required this.hint,
    this.autoLabel = '自动（使用上次使用的模型）',
    required this.onChanged,
    this.allowNull = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(aiProvidersProvider);
    final enabledProviders = providers.where((p) => p.enabled).toList();

    final items = <DropdownMenuItem<String?>>[];

    if (allowNull) {
      items.add(DropdownMenuItem<String?>(
        value: null,
        child: Text(
          autoLabel,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ));
    }

    for (final provider in enabledProviders) {
      for (final model in provider.models) {
        final modelKey = '${provider.id}:${model.id}';
        items.add(DropdownMenuItem<String?>(
          value: modelKey,
          child: Text('${provider.name} / ${model.displayName}'),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              hint: Text(hint),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (hint.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            hint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ],
    );
  }
}
