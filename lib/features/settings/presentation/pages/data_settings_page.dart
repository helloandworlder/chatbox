import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/di/providers.dart';
import '../../data/data_service.dart';

class DataSettingsPage extends ConsumerWidget {
  const DataSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.data.title'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'settings.data.subtitle'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),

          // Export
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: Text('settings.data.export'.tr()),
            subtitle: Text('settings.data.export_hint'.tr()),
            onTap: () => _exportData(context, ref),
          ),

          // Import
          ListTile(
            leading: const Icon(Icons.upload_outlined),
            title: Text('settings.data.import'.tr()),
            subtitle: Text('settings.data.import_hint'.tr()),
            onTap: () => _importData(context, ref),
          ),

          const Divider(height: 32),

          // Clear Data
          ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'settings.data.clear'.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            onTap: () => _confirmClearData(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final exportService = DataExportService(db);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text('settings.data.exporting'.tr()),
          ],
        ),
      ),
    );

    try {
      await exportService.shareExport();
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('settings.data.export_success'.tr())),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'settings.data.export_failed'.tr()}: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings.data.import'.tr()),
        content: Text('settings.data.import_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('common.cancel'.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('settings.data.import'.tr()),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final db = ref.read(databaseProvider);
    final importService = DataImportService(db);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text('settings.data.importing'.tr()),
          ],
        ),
      ),
    );

    final result = await importService.importFromFile();

    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.success
              ? null
              : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _confirmClearData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings.data.clear'.tr()),
        content: Text('settings.data.clear_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('common.cancel'.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    // Double confirm
    final doubleConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('common.confirm'.tr()),
        content: Text('settings.data.clear_confirm_final'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('common.cancel'.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text('common.confirm'.tr()),
          ),
        ],
      ),
    );

    if (doubleConfirmed != true || !context.mounted) return;

    final db = ref.read(databaseProvider);

    try {
      await db.delete(db.messages).go();
      await db.delete(db.sessions).go();
      await db.delete(db.mcpServers).go();
      await db.delete(db.knowledgeBaseFiles).go();
      await db.delete(db.knowledgeBases).go();
      await db.delete(db.copilots).go();
      await db.delete(db.settings).go();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('settings.data.clear_success'.tr())),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'settings.data.clear_failed'.tr()}: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
