import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../copilots/presentation/providers/copilot_provider.dart';
import '../../../copilots/presentation/widgets/copilot_picker.dart';
import '../providers/chat_provider.dart';
import '../widgets/message_list.dart';
import '../widgets/input_box/attachment_picker.dart';
import '../widgets/input_box/input_box.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  String? _pendingCopilotId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check for copilotId passed via route extra
    final extra = GoRouterState.of(context).extra;
    if (extra is Map<String, dynamic> && extra['copilotId'] != null) {
      _handleCopilotSelection(extra['copilotId'] as String);
    }
  }

  Future<void> _handleCopilotSelection(String copilotId) async {
    final sessionId = ref.read(currentSessionIdProvider);
    if (sessionId != null) {
      // Update existing session with copilot
      await ref.read(chatActionsProvider).setSessionCopilot(sessionId, copilotId);
    } else {
      // Create new session with copilot
      await ref.read(chatActionsProvider).createSession(copilotId: copilotId);
    }
    setState(() {
      _pendingCopilotId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(currentSessionIdProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => context.push('/sessions'),
        ),
        title: const Text('Chatbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await ref.read(chatActionsProvider).createSession();
            },
          ),
        ],
      ),
      body: sessionId == null
          ? _buildEmptyState(context)
          : _buildChatContent(context, sessionId),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final copilotsAsync = ref.watch(copilotsProvider);
    final hasCopilots = copilotsAsync.maybeWhen(
      data: (copilots) => copilots.isNotEmpty,
      orElse: () => false,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Start a new conversation',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                await ref.read(chatActionsProvider).createSession();
              },
              icon: const Icon(Icons.add),
              label: const Text('New Chat'),
            ),
            if (hasCopilots) ...[
              const SizedBox(height: 32),
              Text(
                'Or start with a Copilot',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 12),
              CopilotPicker(
                selectedCopilotId: _pendingCopilotId,
                onSelect: (copilot) async {
                  if (copilot != null) {
                    setState(() {
                      _pendingCopilotId = copilot.id;
                    });
                    await ref.read(chatActionsProvider).createSession(
                      copilotId: copilot.id,
                    );
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChatContent(BuildContext context, String sessionId) {
    final sessionsAsync = ref.watch(sessionsProvider);
    final session = sessionsAsync.maybeWhen(
      data: (sessions) => sessions.where((s) => s.id == sessionId).firstOrNull,
      orElse: () => null,
    );
    final copilotId = session?.copilotId;

    return Column(
      children: [
        if (copilotId != null)
          SelectedCopilotBanner(
            copilotId: copilotId,
            onClear: () async {
              await ref.read(chatActionsProvider).setSessionCopilot(sessionId, null);
            },
          ),
        Expanded(
          child: MessageList(sessionId: sessionId),
        ),
        InputBox(
          sessionId: sessionId,
          onSubmit: (content, {List<Attachment>? attachments, bool enableWebSearch = false}) async {
            await ref.read(chatActionsProvider).sendMessage(
              sessionId,
              content,
              attachments: attachments,
              enableWebSearch: enableWebSearch,
            );
          },
        ),
      ],
    );
  }
}
