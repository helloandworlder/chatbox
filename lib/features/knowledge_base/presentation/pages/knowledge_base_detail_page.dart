import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/storage/database/app_database.dart';
import '../providers/knowledge_base_provider.dart';
import '../widgets/file_card.dart';

class KnowledgeBaseDetailPage extends ConsumerStatefulWidget {
  final String knowledgeBaseId;

  const KnowledgeBaseDetailPage({
    super.key,
    required this.knowledgeBaseId,
  });

  @override
  ConsumerState<KnowledgeBaseDetailPage> createState() =>
      _KnowledgeBaseDetailPageState();
}

class _KnowledgeBaseDetailPageState
    extends ConsumerState<KnowledgeBaseDetailPage> {
  bool _isIndexing = false;
  String? _indexingFileId;
  int _indexProgress = 0;
  String? _indexStatus;

  @override
  Widget build(BuildContext context) {
    final files =
        ref.watch(knowledgeBaseFilesProvider(widget.knowledgeBaseId));
    final kbFuture = ref.watch(databaseProvider).getKnowledgeBase(widget.knowledgeBaseId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<KnowledgeBase?>(
          future: kbFuture,
          builder: (context, snapshot) {
            return Text(snapshot.data?.name ?? 'Knowledge Base');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context),
          ),
        ],
      ),
      body: files.when(
        data: (fileList) {
          if (fileList.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildFileList(context, fileList);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isIndexing ? null : _addFile,
        icon: _isIndexing
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              )
            : const Icon(Icons.add),
        label: Text(_isIndexing ? 'Indexing...' : 'Add File'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Files',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add files to this knowledge base to enable search',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _addFile,
            icon: const Icon(Icons.add),
            label: const Text('Add File'),
          ),
        ],
      ),
    );
  }

  Widget _buildFileList(BuildContext context, List<KnowledgeBaseFile> files) {
    return Column(
      children: [
        // 索引进度条
        if (_isIndexing) _buildIndexingProgress(),

        // 文件列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return FileCard(
                file: file,
                isIndexing: _indexingFileId == file.id,
                progress: _indexingFileId == file.id ? _indexProgress : null,
                statusText: _indexingFileId == file.id ? _indexStatus : null,
                onIndex: () => _indexFile(file),
                onReindex: () => _reindexFile(file),
                onDelete: () => _confirmDeleteFile(file),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIndexingProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _indexStatus ?? 'Indexing...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                '$_indexProgress%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _indexProgress / 100,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ],
      ),
    );
  }

  Future<void> _addFile() async {
    final actions = ref.read(knowledgeBaseActionsProvider);
    final fileId = await actions.addFileToKnowledgeBase(widget.knowledgeBaseId);

    if (fileId != null) {
      // 自动开始索引
      await _indexFileById(fileId);
    }
  }

  Future<void> _indexFile(KnowledgeBaseFile file) async {
    await _indexFileById(file.id);
  }

  Future<void> _indexFileById(String fileId) async {
    setState(() {
      _isIndexing = true;
      _indexingFileId = fileId;
      _indexProgress = 0;
      _indexStatus = 'Starting...';
    });

    try {
      final actions = ref.read(knowledgeBaseActionsProvider);
      await actions.indexFile(
        widget.knowledgeBaseId,
        fileId,
        onProgress: (current, total, status) {
          if (mounted) {
            setState(() {
              _indexProgress = current;
              _indexStatus = status;
            });
          }
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File indexed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Indexing failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isIndexing = false;
          _indexingFileId = null;
          _indexProgress = 0;
          _indexStatus = null;
        });
      }
    }
  }

  Future<void> _reindexFile(KnowledgeBaseFile file) async {
    setState(() {
      _isIndexing = true;
      _indexingFileId = file.id;
      _indexProgress = 0;
      _indexStatus = 'Re-indexing...';
    });

    try {
      final actions = ref.read(knowledgeBaseActionsProvider);
      await actions.reindexFile(
        widget.knowledgeBaseId,
        file.id,
        onProgress: (current, total, status) {
          if (mounted) {
            setState(() {
              _indexProgress = current;
              _indexStatus = status;
            });
          }
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File re-indexed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Re-indexing failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isIndexing = false;
          _indexingFileId = null;
          _indexProgress = 0;
          _indexStatus = null;
        });
      }
    }
  }

  void _confirmDeleteFile(KnowledgeBaseFile file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete File'),
        content: Text(
          'Are you sure you want to delete "${file.fileName}"?\n\n'
          'This will also delete all indexed data for this file.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              await ref
                  .read(knowledgeBaseActionsProvider)
                  .deleteFile(widget.knowledgeBaseId, file.id);

              if (mounted) {
                messenger.showSnackBar(
                  SnackBar(content: Text('Deleted "${file.fileName}"')),
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

  Future<void> _showEditDialog(BuildContext context) async {
    final kb =
        await ref.read(databaseProvider).getKnowledgeBase(widget.knowledgeBaseId);
    if (kb == null || !mounted) return;

    final nameController = TextEditingController(text: kb.name);
    final descController = TextEditingController(text: kb.description ?? '');

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Knowledge Base'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
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

              await ref.read(knowledgeBaseActionsProvider).updateKnowledgeBase(
                    id: widget.knowledgeBaseId,
                    name: name,
                    description: descController.text.trim().isNotEmpty
                        ? descController.text.trim()
                        : null,
                  );

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
