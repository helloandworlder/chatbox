import 'package:flutter/material.dart';

import '../../domain/copilot.dart';

class CopilotCard extends StatelessWidget {
  final CopilotEntity copilot;
  final VoidCallback onTap;
  final VoidCallback onToggleStarred;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CopilotCard({
    super.key,
    required this.copilot,
    required this.onTap,
    required this.onToggleStarred,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage:
                    copilot.picUrl != null ? NetworkImage(copilot.picUrl!) : null,
                child: copilot.picUrl == null
                    ? Icon(
                        Icons.smart_toy,
                        color: theme.colorScheme.onPrimaryContainer,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      copilot.name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      copilot.prompt,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  copilot.starred ? Icons.star : Icons.star_border,
                  color: copilot.starred ? Colors.amber : null,
                ),
                onPressed: onToggleStarred,
                tooltip: copilot.starred ? 'Unstar' : 'Star',
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
