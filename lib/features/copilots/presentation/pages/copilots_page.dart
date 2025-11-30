import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/copilot.dart';
import '../providers/copilot_provider.dart';
import '../widgets/copilot_card.dart';
import '../widgets/copilot_form.dart';

class CopilotsPage extends ConsumerStatefulWidget {
  const CopilotsPage({super.key});

  @override
  ConsumerState<CopilotsPage> createState() => _CopilotsPageState();
}

class _CopilotsPageState extends ConsumerState<CopilotsPage> {
  CopilotEntity? _editingCopilot;
  bool _isCreating = false;

  void _startCreate() {
    setState(() {
      _isCreating = true;
      _editingCopilot = null;
    });
  }

  void _startEdit(CopilotEntity copilot) {
    setState(() {
      _editingCopilot = copilot;
      _isCreating = false;
    });
  }

  void _cancelForm() {
    setState(() {
      _isCreating = false;
      _editingCopilot = null;
    });
  }

  Future<void> _saveForm(String name, String prompt, String? picUrl) async {
    final actions = ref.read(copilotActionsProvider);
    if (_editingCopilot != null) {
      await actions.update(
        id: _editingCopilot!.id,
        name: name,
        prompt: prompt,
        picUrl: picUrl,
      );
    } else {
      await actions.create(
        name: name,
        prompt: prompt,
        picUrl: picUrl,
      );
    }
    _cancelForm();
  }

  Future<void> _deleteCopilot(CopilotEntity copilot) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Copilot'),
        content: Text('Are you sure you want to delete "${copilot.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(copilotActionsProvider).delete(copilot.id);
    }
  }

  void _useCopilot(CopilotEntity copilot) {
    ref.read(copilotActionsProvider).incrementUsedCount(copilot.id);
    context.go('/chat', extra: {'copilotId': copilot.id});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final copilotsAsync = ref.watch(copilotsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Copilots'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_isCreating || _editingCopilot != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: CopilotForm(
                copilot: _editingCopilot,
                onSave: _saveForm,
                onCancel: _cancelForm,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: _startCreate,
                icon: const Icon(Icons.add),
                label: const Text('Create New Copilot'),
              ),
            ),
          Expanded(
            child: copilotsAsync.when(
              data: (copilots) {
                if (copilots.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.smart_toy_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Copilots yet',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create a Copilot to get started',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: copilots.length,
                  itemBuilder: (context, index) {
                    final copilot = copilots[index];
                    return CopilotCard(
                      copilot: copilot,
                      onTap: () => _useCopilot(copilot),
                      onToggleStarred: () => ref
                          .read(copilotActionsProvider)
                          .toggleStarred(copilot.id),
                      onEdit: () => _startEdit(copilot),
                      onDelete: () => _deleteCopilot(copilot),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
