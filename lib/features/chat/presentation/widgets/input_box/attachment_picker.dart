import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

enum AttachmentType { image, file }

class Attachment {
  final String id;
  final AttachmentType type;
  final String path;
  final String name;
  final int? size;
  final String? mimeType;

  const Attachment({
    required this.id,
    required this.type,
    required this.path,
    required this.name,
    this.size,
    this.mimeType,
  });
}

class AttachmentPicker {
  final ImagePicker _imagePicker = ImagePicker();
  int _idCounter = 0;

  String _generateId() => 'attachment_${DateTime.now().millisecondsSinceEpoch}_${_idCounter++}';

  Future<Attachment?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image == null) return null;

      final file = File(image.path);
      final stat = await file.stat();

      return Attachment(
        id: _generateId(),
        type: AttachmentType.image,
        path: image.path,
        name: p.basename(image.path),
        size: stat.size,
        mimeType: image.mimeType,
      );
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  Future<List<Attachment>> pickMultipleImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      final attachments = <Attachment>[];
      for (final image in images) {
        final file = File(image.path);
        final stat = await file.stat();
        attachments.add(Attachment(
          id: _generateId(),
          type: AttachmentType.image,
          path: image.path,
          name: p.basename(image.path),
          size: stat.size,
          mimeType: image.mimeType,
        ));
      }
      return attachments;
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      return [];
    }
  }

  Future<Attachment?> takePhoto() async {
    return pickImage(source: ImageSource.camera);
  }

  Future<List<Attachment>> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result == null) return [];

      final attachments = <Attachment>[];
      for (final file in result.files) {
        if (file.path != null) {
          final isImage = _isImageFile(file.extension);
          attachments.add(Attachment(
            id: _generateId(),
            type: isImage ? AttachmentType.image : AttachmentType.file,
            path: file.path!,
            name: file.name,
            size: file.size,
            mimeType: _getMimeType(file.extension),
          ));
        }
      }
      return attachments;
    } catch (e) {
      debugPrint('Error picking files: $e');
      return [];
    }
  }

  bool _isImageFile(String? extension) {
    if (extension == null) return false;
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'heic', 'heif'];
    return imageExtensions.contains(extension.toLowerCase());
  }

  String? _getMimeType(String? extension) {
    if (extension == null) return null;
    final mimeTypes = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'md': 'text/markdown',
      'json': 'application/json',
      'csv': 'text/csv',
    };
    return mimeTypes[extension.toLowerCase()];
  }
}

class AttachmentPreview extends StatelessWidget {
  final List<Attachment> attachments;
  final ValueChanged<Attachment> onRemove;

  const AttachmentPreview({
    super.key,
    required this.attachments,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final attachment = attachments[index];
          return _AttachmentThumbnail(
            attachment: attachment,
            onRemove: () => onRemove(attachment),
          );
        },
      ),
    );
  }
}

class _AttachmentThumbnail extends StatelessWidget {
  final Attachment attachment;
  final VoidCallback onRemove;

  const _AttachmentThumbnail({
    required this.attachment,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: attachment.type == AttachmentType.image
              ? Image.file(
                  File(attachment.path),
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => _buildFilePlaceholder(context),
                )
              : _buildFilePlaceholder(context),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: colorScheme.error,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 14,
                color: colorScheme.onError,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 32,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              attachment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttachmentMenuSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onFile;

  const AttachmentMenuSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
    required this.onFile,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                onCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                onGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Choose File'),
              onTap: () {
                Navigator.pop(context);
                onFile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
