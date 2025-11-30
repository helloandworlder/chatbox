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
            onTap: () => _showExportDialog(context, ref),
          ),

          // Import
          ListTile(
            leading: const Icon(Icons.upload_outlined),
            title: Text('settings.data.import'.tr()),
            subtitle: Text('settings.data.import_hint'.tr()),
            onTap: () => _showImportDialog(context, ref),
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

  Future<void> _showExportDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<ExportOptions>(
      context: context,
      builder: (context) => const _ExportOptionsDialog(),
    );

    if (result == null || result.isEmpty || !context.mounted) return;

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
      // 获取按钮位置作为 sharePositionOrigin (iOS/macOS 需要)
      final box = context.findRenderObject() as RenderBox?;
      final sharePositionOrigin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : null;

      await exportService.shareExport(
        options: result,
        sharePositionOrigin: sharePositionOrigin,
      );
      
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

  Future<void> _showImportDialog(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final importService = DataImportService(db);

    // 选择文件并预览
    final preview = await importService.pickAndPreview();
    if (preview == null || !context.mounted) return;

    if (preview.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('settings.data.import_empty'.tr()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    // 显示导入选项对话框
    final options = await showDialog<ImportOptions>(
      context: context,
      builder: (context) => _ImportOptionsDialog(preview: preview),
    );

    if (options == null || !context.mounted) return;

    // 执行导入
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

    final result = await importService.importFromJson(preview.rawJson, options: options);

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

/// 导出选项对话框
class _ExportOptionsDialog extends StatefulWidget {
  const _ExportOptionsDialog();

  @override
  State<_ExportOptionsDialog> createState() => _ExportOptionsDialogState();
}

class _ExportOptionsDialogState extends State<_ExportOptionsDialog> {
  bool _sessions = true;
  bool _providers = true;
  bool _mcpServers = true;
  bool _knowledgeBases = true;
  bool _settings = true;

  bool get _selectAll =>
      _sessions && _providers && _mcpServers && _knowledgeBases && _settings;

  void _toggleAll(bool? value) {
    setState(() {
      _sessions = value ?? false;
      _providers = value ?? false;
      _mcpServers = value ?? false;
      _knowledgeBases = value ?? false;
      _settings = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择导出内容'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('全选'),
              value: _selectAll,
              onChanged: _toggleAll,
              tristate: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(),
            CheckboxListTile(
              title: const Text('对话记录'),
              subtitle: const Text('包含所有会话和消息'),
              value: _sessions,
              onChanged: (v) => setState(() => _sessions = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('AI Providers'),
              subtitle: const Text('API 配置和模型列表'),
              value: _providers,
              onChanged: (v) => setState(() => _providers = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('MCP 服务器'),
              subtitle: const Text('MCP 服务器配置'),
              value: _mcpServers,
              onChanged: (v) => setState(() => _mcpServers = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('知识库'),
              subtitle: const Text('知识库配置（不含文件）'),
              value: _knowledgeBases,
              onChanged: (v) => setState(() => _knowledgeBases = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('应用设置'),
              subtitle: const Text('主题、语言等设置'),
              value: _settings,
              onChanged: (v) => setState(() => _settings = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              ExportOptions(
                sessions: _sessions,
                providers: _providers,
                mcpServers: _mcpServers,
                knowledgeBases: _knowledgeBases,
                settings: _settings,
              ),
            );
          },
          child: const Text('导出'),
        ),
      ],
    );
  }
}

/// 导入选项对话框
class _ImportOptionsDialog extends StatefulWidget {
  final ImportPreview preview;

  const _ImportOptionsDialog({required this.preview});

  @override
  State<_ImportOptionsDialog> createState() => _ImportOptionsDialogState();
}

class _ImportOptionsDialogState extends State<_ImportOptionsDialog> {
  late bool _sessions;
  late bool _providers;
  late bool _mcpServers;
  late bool _knowledgeBases;
  late bool _settings;

  @override
  void initState() {
    super.initState();
    _sessions = widget.preview.sessionsCount > 0;
    _providers = widget.preview.hasProviders;
    _mcpServers = widget.preview.hasMcpServers;
    _knowledgeBases = widget.preview.hasKnowledgeBases;
    _settings = widget.preview.hasSettings;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择导入内容'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '文件包含以下内容：',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            if (widget.preview.sessionsCount > 0)
              CheckboxListTile(
                title: const Text('对话记录'),
                subtitle: Text(
                  '${widget.preview.sessionsCount} 个会话, ${widget.preview.messagesCount} 条消息',
                ),
                value: _sessions,
                onChanged: (v) => setState(() => _sessions = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            if (widget.preview.hasProviders)
              CheckboxListTile(
                title: const Text('AI Providers'),
                subtitle: const Text('API 配置和模型列表'),
                value: _providers,
                onChanged: (v) => setState(() => _providers = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            if (widget.preview.hasMcpServers)
              CheckboxListTile(
                title: const Text('MCP 服务器'),
                subtitle: const Text('MCP 服务器配置'),
                value: _mcpServers,
                onChanged: (v) => setState(() => _mcpServers = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            if (widget.preview.hasKnowledgeBases)
              CheckboxListTile(
                title: const Text('知识库'),
                subtitle: const Text('知识库配置'),
                value: _knowledgeBases,
                onChanged: (v) => setState(() => _knowledgeBases = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            if (widget.preview.hasSettings)
              CheckboxListTile(
                title: const Text('应用设置'),
                subtitle: const Text('主题、语言等设置'),
                value: _settings,
                onChanged: (v) => setState(() => _settings = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            if (widget.preview.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('文件中没有可导入的数据'),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              ImportOptions(
                sessions: _sessions,
                providers: _providers,
                mcpServers: _mcpServers,
                knowledgeBases: _knowledgeBases,
                settings: _settings,
              ),
            );
          },
          child: const Text('导入'),
        ),
      ],
    );
  }
}
