import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain/langchain.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/storage/database/app_database.dart';
import '../../../ai_models/presentation/providers/ai_provider.dart';
import '../../../knowledge_base/presentation/providers/knowledge_base_provider.dart';
import '../../../mcp/presentation/providers/mcp_provider.dart';
import '../../../tools/data/search_service.dart';
import '../widgets/input_box/attachment_picker.dart';

final currentSessionIdProvider = StateProvider<String?>((ref) => null);

final sessionsProvider = StreamProvider<List<Session>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllSessions();
});

final messagesProvider =
    StreamProvider.family<List<Message>, String>((ref, sessionId) {
  final db = ref.watch(databaseProvider);
  return db.watchMessages(sessionId);
});

final isGeneratingProvider = StateProvider<bool>((ref) => false);
final streamingMessageIdProvider = StateProvider<String?>((ref) => null);
final streamingContentProvider = StateProvider<String>((ref) => '');

final chatActionsProvider = Provider((ref) => ChatActions(ref));

class ChatActions {
  final Ref _ref;
  final _uuid = const Uuid();
  StreamSubscription? _streamSubscription;

  ChatActions(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<String> createSession({String? name, String? copilotId}) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await _db.insertSession(SessionsCompanion(
      id: Value(id),
      name: Value(name ?? 'New Chat'),
      copilotId: Value(copilotId),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));
    _ref.read(currentSessionIdProvider.notifier).state = id;
    return id;
  }

  Future<void> setSessionCopilot(String sessionId, String? copilotId) async {
    final session = await _db.getSession(sessionId);
    if (session != null) {
      await _db.updateSession(SessionsCompanion(
        id: Value(sessionId),
        name: Value(session.name),
        type: Value(session.type),
        starred: Value(session.starred),
        copilotId: Value(copilotId),
        settingsJson: Value(session.settingsJson),
        createdAt: Value(session.createdAt),
        updatedAt: Value(DateTime.now()),
      ));
    }
  }

  Future<void> deleteSession(String id) async {
    await _db.deleteSessionMessages(id);
    await _db.deleteSession(id);
    if (_ref.read(currentSessionIdProvider) == id) {
      _ref.read(currentSessionIdProvider.notifier).state = null;
    }
  }

  Future<void> updateSessionName(String id, String name) async {
    final session = await _db.getSession(id);
    if (session != null) {
      await _db.updateSession(SessionsCompanion(
        id: Value(id),
        name: Value(name),
        type: Value(session.type),
        starred: Value(session.starred),
        copilotId: Value(session.copilotId),
        settingsJson: Value(session.settingsJson),
        createdAt: Value(session.createdAt),
        updatedAt: Value(DateTime.now()),
      ));
    }
  }

  Future<void> toggleStarred(String id) async {
    final session = await _db.getSession(id);
    if (session != null) {
      await _db.updateSession(SessionsCompanion(
        id: Value(id),
        name: Value(session.name),
        type: Value(session.type),
        starred: Value(!session.starred),
        copilotId: Value(session.copilotId),
        settingsJson: Value(session.settingsJson),
        createdAt: Value(session.createdAt),
        updatedAt: Value(DateTime.now()),
      ));
    }
  }

  Future<void> sendMessage(
    String sessionId,
    String content, {
    List<Attachment>? attachments,
    bool enableWebSearch = false,
  }) async {
    final providerId = _ref.read(currentProviderIdProvider);
    final modelId = _ref.read(currentModelIdProvider);

    if (providerId == null || modelId == null) {
      throw Exception('No AI provider configured');
    }

    // 0. Check for web search context
    String webSearchContext = '';
    if (enableWebSearch && content.isNotEmpty) {
      final searchService = _ref.read(searchServiceProvider);
      if (searchService.isConfigured) {
        try {
          final searchResult = await searchService.searchAndFormat(content);
          webSearchContext = '\n\n[Web Search Results]\n$searchResult\n[End of Search Results]\n\n';
        } catch (e) {
          // Web search failed, continue without context
        }
      }
    }

    // 0.2 Get available MCP tools
    String mcpToolsContext = '';
    final mcpTools = _ref.read(mcpToolsProvider);
    if (mcpTools.isNotEmpty) {
      final toolDescriptions = mcpTools.map((t) {
        final schemaStr = t.inputSchema != null 
            ? '\n     Parameters: ${jsonEncode(t.inputSchema)}'
            : '';
        return '   - ${t.name}: ${t.description ?? "No description"}$schemaStr';
      }).join('\n');
      mcpToolsContext = '''

[Available MCP Tools]
You have access to the following tools. To use a tool, respond with a JSON block like this:
```tool
{"tool": "tool_name", "arguments": {"arg1": "value1"}}
```

Available tools:
$toolDescriptions

After using a tool, wait for the result before continuing.
[End of MCP Tools]

''';
    }

    // 0.1 Check for RAG context
    String ragContext = '';
    final selectedKbIds = _ref.read(selectedKnowledgeBaseIdsProvider);
    if (selectedKbIds.isNotEmpty && content.isNotEmpty) {
      try {
        final ragService = await _ref.read(ragServiceProvider.future);
        final results = await ragService.searchMultiple(
          selectedKbIds,
          content,
          k: 5,
        );
        if (results.isNotEmpty) {
          final contextParts = results.map((r) => 
            '--- From ${r.fileName} ---\n${r.content}'
          ).join('\n\n');
          ragContext = '\n\n[Knowledge Base Context]\n$contextParts\n[End of Context]\n\n';
        }
      } catch (e) {
        // RAG search failed, continue without context
      }
    }

    // 1. Build content parts for user message
    final contentParts = <Map<String, dynamic>>[];
    
    // Add text content
    if (content.isNotEmpty) {
      contentParts.add({'type': 'text', 'text': content});
    }
    
    // Add attachments
    if (attachments != null && attachments.isNotEmpty) {
      for (final attachment in attachments) {
        if (attachment.type == AttachmentType.image) {
          // Read image and convert to base64 for vision models
          try {
            final file = File(attachment.path);
            final bytes = await file.readAsBytes();
            final base64Image = base64Encode(bytes);
            final mimeType = attachment.mimeType ?? 'image/jpeg';
            contentParts.add({
              'type': 'image',
              'url': 'data:$mimeType;base64,$base64Image',
              'name': attachment.name,
            });
          } catch (e) {
            // Failed to read image, add as file reference
            contentParts.add({
              'type': 'file',
              'path': attachment.path,
              'name': attachment.name,
            });
          }
        } else {
          // Non-image file
          contentParts.add({
            'type': 'file',
            'path': attachment.path,
            'name': attachment.name,
          });
        }
      }
    }

    // 2. Save user message
    final userMsgId = _uuid.v4();
    await _db.insertMessage(MessagesCompanion(
      id: Value(userMsgId),
      sessionId: Value(sessionId),
      role: const Value('user'),
      contentJson: Value(jsonEncode(contentParts)),
      createdAt: Value(DateTime.now()),
    ));

    // 2. Create placeholder assistant message
    final assistantMsgId = _uuid.v4();
    await _db.insertMessage(MessagesCompanion(
      id: Value(assistantMsgId),
      sessionId: Value(sessionId),
      role: const Value('assistant'),
      contentJson: const Value('[{"type":"text","text":""}]'),
      model: Value('$providerId:$modelId'),
      generating: const Value(true),
      createdAt: Value(DateTime.now()),
    ));

    // 3. Set generating state
    _ref.read(isGeneratingProvider.notifier).state = true;
    _ref.read(streamingMessageIdProvider.notifier).state = assistantMsgId;
    _ref.read(streamingContentProvider.notifier).state = '';

    // 4. Get conversation history
    final messages = await _db.getMessages(sessionId);
    var chatMessages = _convertToChatMessages(
      messages.where((m) => m.id != assistantMsgId).toList(),
    );

    // 4.1 Inject Copilot system prompt if session has a copilot
    final session = await _db.getSession(sessionId);
    if (session?.copilotId != null) {
      final copilot = await _db.getCopilot(session!.copilotId!);
      if (copilot != null && copilot.prompt.isNotEmpty) {
        chatMessages = [
          ChatMessage.system(copilot.prompt),
          ...chatMessages,
        ];
      }
    }

    // 4.2 Inject MCP tools context as system message
    if (mcpToolsContext.isNotEmpty) {
      // Insert MCP tools context after the first system message (if any)
      final firstSystemIndex = chatMessages.indexWhere((m) => m is SystemChatMessage);
      if (firstSystemIndex >= 0) {
        chatMessages = [
          ...chatMessages.sublist(0, firstSystemIndex + 1),
          ChatMessage.system(mcpToolsContext),
          ...chatMessages.sublist(firstSystemIndex + 1),
        ];
      } else {
        chatMessages = [
          ChatMessage.system(mcpToolsContext),
          ...chatMessages,
        ];
      }
    }

    // 4.3 Inject web search and RAG context into the last user message
    final combinedContext = '$webSearchContext$ragContext';
    if (combinedContext.isNotEmpty && chatMessages.isNotEmpty) {
      final lastMessage = chatMessages.last;
      if (lastMessage is HumanChatMessage) {
        final originalContent = lastMessage.contentAsString;
        chatMessages = [
          ...chatMessages.sublist(0, chatMessages.length - 1),
          ChatMessage.humanText('$combinedContext$originalContent'),
        ];
      }
    }

    // 5. Stream response
    final llm = _ref.read(llmServiceProvider);
    String fullContent = '';

    try {
      final stream = llm.streamChat(
        providerId: providerId,
        modelId: modelId,
        messages: chatMessages,
      );

      await for (final chunk in stream) {
        if (chunk.text != null) {
          fullContent += chunk.text!;
          _ref.read(streamingContentProvider.notifier).state = fullContent;
        }

        if (chunk.isFinished) {
          break;
        }
      }

      // 5.1 Check for MCP tool calls in response
      if (mcpTools.isNotEmpty) {
        final toolCallResult = await _handleMcpToolCalls(
          fullContent, 
          providerId,
          modelId,
          chatMessages,
          sessionId,
          assistantMsgId,
        );
        if (toolCallResult != null) {
          fullContent = toolCallResult;
        }
      }

      // 6. Save final message
      final escapedFinalContent = jsonEncode(fullContent);
      await _db.updateMessage(MessagesCompanion(
        id: Value(assistantMsgId),
        sessionId: Value(sessionId),
        role: const Value('assistant'),
        contentJson: Value('[{"type":"text","text":$escapedFinalContent}]'),
        model: Value('$providerId:$modelId'),
        generating: const Value(false),
        createdAt: Value(DateTime.now()),
      ));

      // Update session name if this is the first exchange
      if (messages.length <= 1) {
        final sessionName = content.length > 30
            ? '${content.substring(0, 30)}...'
            : content;
        await updateSessionName(sessionId, sessionName);
      }
    } catch (e) {
      // Save error message
      final errorContent = jsonEncode('Error: ${e.toString()}');
      await _db.updateMessage(MessagesCompanion(
        id: Value(assistantMsgId),
        sessionId: Value(sessionId),
        role: const Value('assistant'),
        contentJson: Value('[{"type":"text","text":$errorContent}]'),
        model: Value('$providerId:$modelId'),
        generating: const Value(false),
        createdAt: Value(DateTime.now()),
      ));
      rethrow;
    } finally {
      _ref.read(isGeneratingProvider.notifier).state = false;
      _ref.read(streamingMessageIdProvider.notifier).state = null;
      _ref.read(streamingContentProvider.notifier).state = '';
    }
  }

  void stopGeneration() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _ref.read(isGeneratingProvider.notifier).state = false;
  }

  List<ChatMessage> _convertToChatMessages(List<Message> messages) {
    return messages.map((m) {
      final contentList = jsonDecode(m.contentJson) as List;
      final textContent = contentList
          .where((c) => c['type'] == 'text')
          .map((c) => c['text'] as String)
          .join('\n');

      return switch (m.role) {
        'user' => ChatMessage.humanText(textContent),
        'assistant' => ChatMessage.ai(textContent),
        'system' => ChatMessage.system(textContent),
        _ => ChatMessage.humanText(textContent),
      };
    }).toList();
  }

  /// Handle MCP tool calls in the LLM response
  Future<String?> _handleMcpToolCalls(
    String content,
    String providerId,
    String modelId,
    List<ChatMessage> chatMessages,
    String sessionId,
    String assistantMsgId,
  ) async {
    // Parse tool call blocks from content
    final toolCallPattern = RegExp(
      r'```tool\s*\n([\s\S]*?)\n```',
      multiLine: true,
    );

    final matches = toolCallPattern.allMatches(content);
    if (matches.isEmpty) return null;

    final mcpActions = _ref.read(mcpActionsProvider);
    final toolResults = <String>[];
    String modifiedContent = content;

    for (final match in matches) {
      final toolJson = match.group(1);
      if (toolJson == null) continue;

      try {
        final toolCall = jsonDecode(toolJson) as Map<String, dynamic>;
        final toolName = toolCall['tool'] as String?;
        final arguments = toolCall['arguments'] as Map<String, dynamic>? ?? {};

        if (toolName == null) continue;

        // Execute the tool
        _ref.read(streamingContentProvider.notifier).state = 
            '$content\n\n[Executing tool: $toolName...]';

        final result = await mcpActions.callTool(toolName, arguments);

        toolResults.add('Tool "$toolName" result:\n$result');

        // Replace tool call block with result
        modifiedContent = modifiedContent.replaceFirst(
          match.group(0)!,
          '\n[Tool Call: $toolName]\nArguments: ${jsonEncode(arguments)}\n\n[Tool Result]\n$result\n[End Tool Result]\n',
        );
      } catch (e) {
        toolResults.add('Tool execution error: $e');
        modifiedContent = modifiedContent.replaceFirst(
          match.group(0)!,
          '\n[Tool Error: $e]\n',
        );
      }
    }

    // If tools were executed, continue the conversation with results
    if (toolResults.isNotEmpty) {
      _ref.read(streamingContentProvider.notifier).state = modifiedContent;

      // Add tool results to context and get follow-up response
      final updatedMessages = [
        ...chatMessages,
        ChatMessage.ai(modifiedContent),
        ChatMessage.humanText(
          'Based on the tool results above, please provide a complete answer.'
        ),
      ];

      // Get follow-up response
      final llm = _ref.read(llmServiceProvider);
      String followUpContent = '';

      final stream = llm.streamChat(
        providerId: providerId,
        modelId: modelId,
        messages: updatedMessages,
      );

      await for (final chunk in stream) {
        if (chunk.text != null) {
          followUpContent += chunk.text!;
          _ref.read(streamingContentProvider.notifier).state = 
              '$modifiedContent\n\n$followUpContent';
        }
        if (chunk.isFinished) break;
      }

      return '$modifiedContent\n\n$followUpContent';
    }

    return null;
  }
}
