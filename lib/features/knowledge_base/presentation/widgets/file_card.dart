import 'package:flutter/material.dart';

import '../../../../core/storage/database/app_database.dart';

class FileCard extends StatelessWidget {
  final KnowledgeBaseFile file;
  final bool isIndexing;
  final int? progress;
  final String? statusText;
  final VoidCallback onIndex;
  final VoidCallback onReindex;
  final VoidCallback onDelete;

  const FileCard({
    super.key,
    required this.file,
    this.isIndexing = false,
    this.progress,
    this.statusText,
    required this.onIndex,
    required this.onReindex,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildFileIcon(context),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.fileName,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatFileSize(file.fileSize),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(context),
              ],
            ),

            // 索引进度
            if (isIndexing && progress != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress! / 100,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$progress%',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              if (statusText != null) ...[
                const SizedBox(height: 4),
                Text(
                  statusText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ],

            // 操作按钮
            const SizedBox(height: 12),
            Row(
              children: [
                if (file.indexStatus == 'idle' || file.indexStatus == 'error')
                  TextButton.icon(
                    onPressed: isIndexing ? null : onIndex,
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Index'),
                  ),
                if (file.indexStatus == 'completed')
                  TextButton.icon(
                    onPressed: isIndexing ? null : onReindex,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Re-index'),
                  ),
                const Spacer(),
                if (file.indexStatus == 'completed')
                  Text(
                    '${file.chunkCount} chunks',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: isIndexing ? null : onDelete,
                  tooltip: 'Delete',
                ),
              ],
            ),

            // 错误信息
            if (file.indexStatus == 'error' &&
                file.indexError != null &&
                file.indexError!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        file.indexError!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFileIcon(BuildContext context) {
    final extension = file.fileName.split('.').last.toLowerCase();
    final (icon, color) = switch (extension) {
      'txt' => (Icons.description, Colors.blue),
      'md' || 'markdown' => (Icons.article, Colors.purple),
      'json' => (Icons.data_object, Colors.orange),
      'csv' => (Icons.table_chart, Colors.green),
      'xml' => (Icons.code, Colors.red),
      'html' => (Icons.html, Colors.orange),
      'pdf' => (Icons.picture_as_pdf, Colors.red),
      _ => (Icons.insert_drive_file, Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final status = file.indexStatus;
    final (color, icon, label) = switch (status) {
      'idle' => (
          Theme.of(context).colorScheme.outline,
          Icons.hourglass_empty,
          'Not indexed'
        ),
      'indexing' => (
          Theme.of(context).colorScheme.primary,
          Icons.sync,
          'Indexing'
        ),
      'completed' => (Colors.green, Icons.check_circle, 'Indexed'),
      'error' => (Theme.of(context).colorScheme.error, Icons.error, 'Error'),
      _ => (
          Theme.of(context).colorScheme.outline,
          Icons.help_outline,
          'Unknown'
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
