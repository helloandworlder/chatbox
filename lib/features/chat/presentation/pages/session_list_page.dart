import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/chat_provider.dart';

class SessionListPage extends ConsumerWidget {
  const SessionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsProvider);
    final currentId = ref.watch(currentSessionIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await ref.read(chatActionsProvider).createSession();
              if (context.mounted) context.pop();
            },
          ),
        ],
      ),
      body: sessionsAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No conversations yet',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              final isSelected = session.id == currentId;
              return ListTile(
                leading: Icon(
                  session.starred ? Icons.star : Icons.chat_bubble_outline,
                  color: session.starred
                      ? Colors.amber
                      : Theme.of(context).colorScheme.outline,
                ),
                title: Text(session.name),
                subtitle: Text(
                  _formatDate(session.updatedAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                selected: isSelected,
                selectedTileColor:
                    Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                  ref.read(currentSessionIdProvider.notifier).state =
                      session.id;
                  context.pop();
                },
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(
                          session.starred ? Icons.star_border : Icons.star,
                        ),
                        title: Text(session.starred ? 'Unstar' : 'Star'),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () {
                        ref.read(chatActionsProvider).toggleStarred(session.id);
                      },
                    ),
                    PopupMenuItem(
                      child: const ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Rename'),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () => _showRenameDialog(context, ref, session),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: Text(
                          'Delete',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () {
                        ref.read(chatActionsProvider).deleteSession(session.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  void _showRenameDialog(
      BuildContext context, WidgetRef ref, dynamic session) async {
    final controller = TextEditingController(text: session.name);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Session'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      ref.read(chatActionsProvider).updateSessionName(session.id, result);
    }
  }
}
