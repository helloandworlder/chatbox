import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AvatarPicker extends StatelessWidget {
  final String? avatarPath;
  final String label;
  final IconData defaultIcon;
  final Color? defaultIconColor;
  final ValueChanged<String?> onChanged;

  const AvatarPicker({
    super.key,
    this.avatarPath,
    required this.label,
    required this.defaultIcon,
    this.defaultIconColor,
    required this.onChanged,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
      imageQuality: 85,
    );

    if (image == null) return;

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final avatarsDir = Directory(p.join(appDir.path, 'avatars'));
      if (!await avatarsDir.exists()) {
        await avatarsDir.create(recursive: true);
      }

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
      final savedPath = p.join(avatarsDir.path, fileName);

      await File(image.path).copy(savedPath);
      onChanged(savedPath);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存图片失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: defaultIconColor?.withValues(alpha: 0.2) ??
                Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          clipBehavior: Clip.antiAlias,
          child: avatarPath != null && File(avatarPath!).existsSync()
              ? Image.file(
                  File(avatarPath!),
                  fit: BoxFit.cover,
                )
              : Icon(
                  defaultIcon,
                  size: 32,
                  color: defaultIconColor ??
                      Theme.of(context).colorScheme.onSurfaceVariant,
                ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: () => _pickImage(context),
              child: const Text('上传图片'),
            ),
          ],
        ),
      ],
    );
  }
}
