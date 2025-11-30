import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/storage/database/app_database.dart';
import '../../../settings/presentation/providers/app_settings_provider.dart';
import '../providers/chat_provider.dart';
import 'markdown/markdown_renderer.dart';
import 'thinking_block.dart';

class MessageItem extends ConsumerWidget {
  final Message message;

  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUser = message.role == 'user';
    final colorScheme = Theme.of(context).colorScheme;
    
    final streamingMessageId = ref.watch(streamingMessageIdProvider);
    final isStreaming = message.id == streamingMessageId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(
                Icons.smart_toy,
                size: 18,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildContent(context, ref, isStreaming),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.secondaryContainer,
              child: Icon(
                Icons.person,
                size: 18,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, bool isStreaming) {
    if (isStreaming) {
      final streamingContent = ref.watch(streamingContentProvider);
      if (streamingContent.isEmpty) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Thinking...'),
          ],
        );
      }
      // 流式响应时实时显示（包括 <think> 标签）
      return _buildMarkdown(context, streamingContent, ref);
    }
    
    if (message.generating) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          const Text('Thinking...'),
        ],
      );
    }

    return _buildMessageContent(context, ref);
  }

  /// 构建带思考内容折叠的 Markdown
  Widget _buildMarkdownWithThinking(BuildContext context, String content, WidgetRef ref) {
    return MessageWithThinking(
      content: content,
      isStreaming: false,
      contentBuilder: (c) => _buildMarkdown(context, c, ref),
    );
  }

  Widget _buildMessageContent(BuildContext context, WidgetRef ref) {
    try {
      final List<dynamic> contentParts = json.decode(message.contentJson);
      final widgets = <Widget>[];
      
      // Group images together
      final images = <Map<String, dynamic>>[];
      
      for (final part in contentParts) {
        final type = part['type'] as String;
        
        switch (type) {
          case 'text':
            if (images.isNotEmpty) {
              widgets.add(_buildImageGrid(context, images));
              images.clear();
            }
            final text = part['text'] as String;
            if (text.isNotEmpty) {
              // 对 assistant 消息处理 <think> 标签
              if (message.role == 'assistant') {
                widgets.add(_buildMarkdownWithThinking(context, text, ref));
              } else {
                widgets.add(_buildMarkdown(context, text, ref));
              }
            }
            break;
          case 'image':
            images.add(part as Map<String, dynamic>);
            break;
          case 'file':
            if (images.isNotEmpty) {
              widgets.add(_buildImageGrid(context, images));
              images.clear();
            }
            widgets.add(_buildFileAttachment(context, part));
            break;
        }
      }
      
      // Add remaining images
      if (images.isNotEmpty) {
        widgets.add(_buildImageGrid(context, images));
      }
      
      if (widgets.isEmpty) {
        return const SizedBox.shrink();
      }
      
      if (widgets.length == 1) {
        return widgets.first;
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets
            .map((w) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: w,
                ))
            .toList(),
      );
    } catch (e) {
      return _buildMarkdown(context, message.contentJson, ref);
    }
  }

  Widget _buildImageGrid(BuildContext context, List<Map<String, dynamic>> images) {
    if (images.length == 1) {
      return _buildSingleImage(context, images.first);
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: images
          .map((img) => SizedBox(
                width: 120,
                height: 120,
                child: _buildImageThumbnail(context, img),
              ))
          .toList(),
    );
  }

  Widget _buildSingleImage(BuildContext context, Map<String, dynamic> imageData) {
    final url = imageData['url'] as String?;
    final name = imageData['name'] as String? ?? 'Image';
    
    Widget imageWidget;
    if (url != null && url.startsWith('data:')) {
      // Base64 encoded image
      final base64Data = url.split(',').last;
      imageWidget = Image.memory(
        base64Decode(base64Data),
        fit: BoxFit.contain,
        errorBuilder: (_, e, s) => _buildImagePlaceholder(context, name),
      );
    } else if (url != null) {
      imageWidget = Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, e, s) => _buildImagePlaceholder(context, name),
      );
    } else {
      imageWidget = _buildImagePlaceholder(context, name);
    }
    
    return GestureDetector(
      onTap: () => _showImageViewer(context, imageData),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
            maxWidth: double.infinity,
          ),
          child: imageWidget,
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(BuildContext context, Map<String, dynamic> imageData) {
    final url = imageData['url'] as String?;
    final name = imageData['name'] as String? ?? 'Image';
    
    Widget imageWidget;
    if (url != null && url.startsWith('data:')) {
      final base64Data = url.split(',').last;
      imageWidget = Image.memory(
        base64Decode(base64Data),
        fit: BoxFit.cover,
        errorBuilder: (_, e, s) => _buildImagePlaceholder(context, name),
      );
    } else if (url != null) {
      imageWidget = Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, e, s) => _buildImagePlaceholder(context, name),
      );
    } else {
      imageWidget = _buildImagePlaceholder(context, name);
    }
    
    return GestureDetector(
      onTap: () => _showImageViewer(context, imageData),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageWidget,
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context, String name) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 32,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showImageViewer(BuildContext context, Map<String, dynamic> imageData) {
    final url = imageData['url'] as String?;
    if (url == null) return;
    
    ImageProvider imageProvider;
    if (url.startsWith('data:')) {
      final base64Data = url.split(',').last;
      imageProvider = MemoryImage(base64Decode(base64Data));
    } else {
      imageProvider = NetworkImage(url);
    }
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          body: PhotoView(
            imageProvider: imageProvider,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          ),
        ),
      ),
    );
  }

  Widget _buildFileAttachment(BuildContext context, Map<String, dynamic> fileData) {
    final name = fileData['name'] as String? ?? 'File';
    final path = fileData['path'] as String?;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (path != null)
                  Text(
                    path,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkdown(BuildContext context, String content, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    return MarkdownRenderer(
      content: content,
      selectable: true,
      enableMermaid: appSettings.mermaidRendering,
      enableArtifacts: appSettings.autoPreviewArtifacts,
      autoPreviewArtifacts: appSettings.autoPreviewArtifacts,
    );
  }
}
