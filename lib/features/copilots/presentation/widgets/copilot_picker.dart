import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/copilot.dart';
import '../providers/copilot_provider.dart';

class CopilotPicker extends ConsumerWidget {
  final String? selectedCopilotId;
  final Function(CopilotEntity?) onSelect;
  final int maxToShow;

  const CopilotPicker({
    super.key,
    this.selectedCopilotId,
    required this.onSelect,
    this.maxToShow = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copilotsAsync = ref.watch(copilotsProvider);
    final theme = Theme.of(context);

    return copilotsAsync.when(
      data: (copilots) {
        if (copilots.isEmpty) return const SizedBox.shrink();

        final displayCopilots = copilots.take(maxToShow).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: displayCopilots.map((copilot) {
              final isSelected = copilot.id == selectedCopilotId;
              return ActionChip(
                avatar: CircleAvatar(
                  radius: 12,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  backgroundImage: copilot.picUrl != null
                      ? NetworkImage(copilot.picUrl!)
                      : null,
                  child: copilot.picUrl == null
                      ? Icon(
                          Icons.smart_toy,
                          size: 14,
                          color: theme.colorScheme.onPrimaryContainer,
                        )
                      : null,
                ),
                label: Text(copilot.name),
                side: isSelected
                    ? BorderSide(color: theme.colorScheme.primary, width: 2)
                    : null,
                backgroundColor: isSelected
                    ? theme.colorScheme.primaryContainer
                    : null,
                onPressed: () {
                  if (isSelected) {
                    onSelect(null);
                  } else {
                    ref.read(copilotActionsProvider).incrementUsedCount(copilot.id);
                    onSelect(copilot);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}

class SelectedCopilotBanner extends ConsumerWidget {
  final String copilotId;
  final VoidCallback onClear;

  const SelectedCopilotBanner({
    super.key,
    required this.copilotId,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copilotAsync = ref.watch(copilotByIdProvider(copilotId));
    final theme = Theme.of(context);

    return copilotAsync.when(
      data: (copilot) {
        if (copilot == null) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primary,
                backgroundImage: copilot.picUrl != null
                    ? NetworkImage(copilot.picUrl!)
                    : null,
                child: copilot.picUrl == null
                    ? Icon(
                        Icons.smart_toy,
                        size: 16,
                        color: theme.colorScheme.onPrimary,
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      copilot.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      copilot.prompt,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer
                            .withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                onPressed: onClear,
                tooltip: 'Clear Copilot',
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
