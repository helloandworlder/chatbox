import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../knowledge_base/presentation/widgets/knowledge_base_selector.dart';
import '../../../../mcp/presentation/providers/mcp_provider.dart';
import '../../../../mcp/presentation/widgets/mcp_status.dart';
import '../../../../settings/presentation/providers/app_settings_provider.dart';
import '../../../../tools/presentation/providers/tool_provider.dart';
import '../session_settings_dialog.dart';
import '../../providers/chat_provider.dart';
import 'attachment_picker.dart';
import 'model_selector.dart';

class InputBox extends ConsumerStatefulWidget {
  final String sessionId;
  final String? sessionSettingsJson;
  final Future<void> Function(String content, {List<Attachment>? attachments, bool enableWebSearch}) onSubmit;

  const InputBox({
    super.key,
    required this.sessionId,
    this.sessionSettingsJson,
    required this.onSubmit,
  });

  @override
  ConsumerState<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends ConsumerState<InputBox> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _attachmentPicker = AttachmentPicker();
  final List<Attachment> _attachments = [];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    final isGenerating = ref.read(isGeneratingProvider);
    if ((text.isEmpty && _attachments.isEmpty) || isGenerating) return;

    final attachments = List<Attachment>.from(_attachments);
    final webSearchEnabled = ref.read(webSearchEnabledProvider);
    _controller.clear();
    setState(() => _attachments.clear());

    try {
      await widget.onSubmit(
        text, 
        attachments: attachments.isNotEmpty ? attachments : null,
        enableWebSearch: webSearchEnabled,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _stopGeneration() {
    ref.read(chatActionsProvider).stopGeneration();
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AttachmentMenuSheet(
        onCamera: _takePhoto,
        onGallery: _pickImages,
        onFile: _pickFiles,
      ),
    );
  }

  Future<void> _takePhoto() async {
    final attachment = await _attachmentPicker.takePhoto();
    if (attachment != null && mounted) {
      setState(() => _attachments.add(attachment));
    }
  }

  Future<void> _pickImages() async {
    final attachments = await _attachmentPicker.pickMultipleImages();
    if (attachments.isNotEmpty && mounted) {
      setState(() => _attachments.addAll(attachments));
    }
  }

  Future<void> _pickFiles() async {
    final attachments = await _attachmentPicker.pickFiles();
    if (attachments.isNotEmpty && mounted) {
      setState(() => _attachments.addAll(attachments));
    }
  }

  void _removeAttachment(Attachment attachment) {
    setState(() => _attachments.remove(attachment));
  }

  void _openSessionSettings() async {
    final sessions = await ref.read(sessionsProvider.future);
    final session = sessions.firstWhere(
      (s) => s.id == widget.sessionId,
      orElse: () => sessions.first,
    );

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) => SessionSettingsDialog(
        sessionId: widget.sessionId,
        sessionName: session.name,
        settingsJson: session.settingsJson,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isGenerating = ref.watch(isGeneratingProvider);
    final mcpStatuses = ref.watch(mcpStatusesProvider).valueOrNull ?? {};
    final webSearchEnabled = ref.watch(webSearchEnabledProvider);
    final appSettings = ref.watch(appSettingsProvider);
    final hasTavilyKey = appSettings.tavilyApiKey?.isNotEmpty ?? false;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_attachments.isNotEmpty)
              AttachmentPreview(
                attachments: _attachments,
                onRemove: _removeAttachment,
              ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: isGenerating ? null : _showAttachmentMenu,
                  tooltip: '添加附件',
                ),
                IconButton(
                  icon: Icon(
                    Icons.language,
                    color: webSearchEnabled && hasTavilyKey
                        ? colorScheme.primary
                        : null,
                  ),
                  onPressed: hasTavilyKey
                      ? () {
                          ref.read(webSearchEnabledProvider.notifier).state =
                              !webSearchEnabled;
                        }
                      : null,
                  tooltip: hasTavilyKey ? '联网搜索' : '请先在设置中配置 Tavily API Key',
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: _openSessionSettings,
                  tooltip: '对话设置',
                ),
                if (mcpStatuses.isNotEmpty)
                  MCPAggregateStatus(
                    statuses: mcpStatuses,
                    onTap: () => context.push('/settings/mcp'),
                  ),
                const SizedBox(width: 4),
                const KnowledgeBaseSelector(),
                const Spacer(),
                const ModelSelector(),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    maxLines: 5,
                    minLines: 1,
                    enabled: !isGenerating,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                const SizedBox(width: 8),
                isGenerating
                    ? IconButton.filled(
                        onPressed: _stopGeneration,
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.error,
                        ),
                        icon: Icon(
                          Icons.stop,
                          color: colorScheme.onError,
                        ),
                      )
                    : IconButton.filled(
                        onPressed: _submit,
                        icon: const Icon(Icons.send),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
