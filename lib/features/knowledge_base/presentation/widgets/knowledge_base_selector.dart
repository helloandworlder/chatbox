import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/knowledge_base_provider.dart';

class KnowledgeBaseSelector extends ConsumerWidget {
  const KnowledgeBaseSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final knowledgeBases = ref.watch(knowledgeBasesProvider);
    final selectedIds = ref.watch(selectedKnowledgeBaseIdsProvider);

    return knowledgeBases.when(
      data: (kbs) {
        // 过滤出有索引的知识库
        final indexedKbs =
            kbs.where((kb) => kb.chunkCount > 0).toList();

        if (indexedKbs.isEmpty) {
          return _buildEmptyState(context);
        }

        return _buildSelector(context, ref, indexedKbs, selectedIds);
      },
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (e, s) => IconButton(
        icon: const Icon(Icons.error_outline),
        onPressed: () => ref.refresh(knowledgeBasesProvider),
        tooltip: 'Error loading knowledge bases',
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Tooltip(
      message: 'No knowledge bases available',
      child: IconButton(
        icon: Icon(
          Icons.folder_special_outlined,
          color: Theme.of(context).colorScheme.outline,
        ),
        onPressed: () => context.push('/settings/knowledge-bases'),
      ),
    );
  }

  Widget _buildSelector(
    BuildContext context,
    WidgetRef ref,
    List kbs,
    List<String> selectedIds,
  ) {
    final hasSelection = selectedIds.isNotEmpty;

    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == '_manage') {
          context.push('/settings/knowledge-bases');
          return;
        }

        final currentIds = ref.read(selectedKnowledgeBaseIdsProvider);
        if (currentIds.contains(value)) {
          ref.read(selectedKnowledgeBaseIdsProvider.notifier).state =
              currentIds.where((id) => id != value).toList();
        } else {
          ref.read(selectedKnowledgeBaseIdsProvider.notifier).state = [
            ...currentIds,
            value
          ];
        }
      },
      itemBuilder: (context) => [
        ...kbs.map((kb) {
          final isSelected = selectedIds.contains(kb.id);
          return PopupMenuItem<String>(
            value: kb.id,
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 20,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kb.name,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Text(
                        '${kb.fileCount} files · ${kb.chunkCount} chunks',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: '_manage',
          child: Row(
            children: [
              Icon(Icons.settings, size: 20),
              SizedBox(width: 8),
              Text('Manage Knowledge Bases'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasSelection
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_special,
              size: 16,
              color: hasSelection
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              hasSelection ? '${selectedIds.length} KB' : 'KB',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: hasSelection
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: hasSelection
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// 简化版知识库指示器 (显示在消息中)
class KnowledgeBaseIndicator extends StatelessWidget {
  final List<String> knowledgeBaseNames;

  const KnowledgeBaseIndicator({
    super.key,
    required this.knowledgeBaseNames,
  });

  @override
  Widget build(BuildContext context) {
    if (knowledgeBaseNames.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            size: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            'Searched: ${knowledgeBaseNames.join(", ")}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
