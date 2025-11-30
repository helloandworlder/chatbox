import 'package:flutter/material.dart';

import '../../domain/copilot.dart';

class CopilotForm extends StatefulWidget {
  final CopilotEntity? copilot;
  final Function(String name, String prompt, String? picUrl) onSave;
  final VoidCallback onCancel;

  const CopilotForm({
    super.key,
    this.copilot,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<CopilotForm> createState() => _CopilotFormState();
}

class _CopilotFormState extends State<CopilotForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _promptController;
  late final TextEditingController _picUrlController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.copilot?.name ?? '');
    _promptController =
        TextEditingController(text: widget.copilot?.prompt ?? '');
    _picUrlController =
        TextEditingController(text: widget.copilot?.picUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _promptController.dispose();
    _picUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        _nameController.text.trim(),
        _promptController.text.trim(),
        _picUrlController.text.trim().isEmpty
            ? null
            : _picUrlController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.copilot != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? 'Edit Copilot' : 'Create Copilot',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'My Assistant',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'System Prompt',
                hintText: 'You are a helpful assistant...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              minLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Prompt is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _picUrlController,
              decoration: const InputDecoration(
                labelText: 'Avatar URL (optional)',
                hintText: 'https://example.com/avatar.png',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _submit,
                  child: Text(isEditing ? 'Save' : 'Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
