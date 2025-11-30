import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/storage/database/app_database.dart';

class DataExportService {
  final AppDatabase _db;

  DataExportService(this._db);

  Future<Map<String, dynamic>> exportData() async {
    // Export sessions
    final sessions = await _getAllSessions();
    
    // Export messages for each session
    final allMessages = <Map<String, dynamic>>[];
    for (final session in sessions) {
      final messages = await _db.getMessages(session['id'] as String);
      for (final message in messages) {
        allMessages.add({
          'id': message.id,
          'sessionId': message.sessionId,
          'role': message.role,
          'contentJson': message.contentJson,
          'model': message.model,
          'generating': message.generating,
          'createdAt': message.createdAt.toIso8601String(),
        });
      }
    }

    // Export AI providers (stored in settings table as JSON)
    final providersJson = await _db.getSetting('ai_providers');
    
    // Export MCP servers
    final mcpServers = await _db.getAllMcpServers();
    
    // Export knowledge bases
    final knowledgeBases = await _db.getAllKnowledgeBases();

    return {
      'version': '2.0.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'sessions': sessions,
      'messages': allMessages,
      'aiProvidersJson': providersJson,
      'mcpServers': mcpServers.map((m) => {
        'id': m.id,
        'name': m.name,
        'transportJson': m.transportJson,
        'enabled': m.enabled,
        'createdAt': m.createdAt.toIso8601String(),
      }).toList(),
      'knowledgeBases': knowledgeBases.map((k) => {
        'id': k.id,
        'name': k.name,
        'description': k.description,
        'embeddingDimensions': k.embeddingDimensions,
        'embeddingProviderId': k.embeddingProviderId,
        'embeddingModel': k.embeddingModel,
        'createdAt': k.createdAt.toIso8601String(),
      }).toList(),
    };
  }

  Future<List<Map<String, dynamic>>> _getAllSessions() async {
    final sessions = await (_db.select(_db.sessions)
          ..orderBy([(_) => OrderingTerm.desc(_db.sessions.updatedAt)]))
        .get();
    
    return sessions.map((s) => {
      'id': s.id,
      'name': s.name,
      'type': s.type,
      'starred': s.starred,
      'copilotId': s.copilotId,
      'settingsJson': s.settingsJson,
      'createdAt': s.createdAt.toIso8601String(),
      'updatedAt': s.updatedAt.toIso8601String(),
    }).toList();
  }

  Future<String> exportToFile() async {
    final data = await exportData();
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);
    
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
    final filePath = '${directory.path}/chatbox_export_$timestamp.json';
    
    final file = File(filePath);
    await file.writeAsString(jsonString);
    
    return filePath;
  }

  Future<void> shareExport() async {
    final filePath = await exportToFile();
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: 'Chatbox Data Export',
    );
  }
}

class DataImportService {
  final AppDatabase _db;

  DataImportService(this._db);

  Future<ImportResult> importFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.isEmpty) {
      return ImportResult(success: false, message: 'No file selected');
    }

    final file = File(result.files.first.path!);
    final content = await file.readAsString();
    
    return importFromJson(content);
  }

  Future<ImportResult> importFromJson(String jsonString) async {
    try {
      final data = json.decode(jsonString) as Map<String, dynamic>;
      final version = data['version'] as String?;
      
      if (version == null) {
        return ImportResult(success: false, message: 'Invalid export file format');
      }

      int sessionsCount = 0;
      int messagesCount = 0;

      // Import sessions
      final sessions = data['sessions'] as List<dynamic>?;
      if (sessions != null) {
        for (final sessionData in sessions) {
          try {
            await _db.into(_db.sessions).insertOnConflictUpdate(
              SessionsCompanion(
                id: Value(sessionData['id'] as String),
                name: Value(sessionData['name'] as String),
                type: Value(sessionData['type'] as String? ?? 'chat'),
                starred: Value(sessionData['starred'] as bool? ?? false),
                copilotId: Value(sessionData['copilotId'] as String?),
                settingsJson: Value(sessionData['settingsJson'] as String?),
                createdAt: Value(DateTime.parse(sessionData['createdAt'] as String)),
                updatedAt: Value(DateTime.parse(sessionData['updatedAt'] as String)),
              ),
            );
            sessionsCount++;
          } catch (e) {
            debugPrint('Error importing session: $e');
          }
        }
      }

      // Import messages
      final messages = data['messages'] as List<dynamic>?;
      if (messages != null) {
        for (final msgData in messages) {
          try {
            await _db.into(_db.messages).insertOnConflictUpdate(
              MessagesCompanion(
                id: Value(msgData['id'] as String),
                sessionId: Value(msgData['sessionId'] as String),
                role: Value(msgData['role'] as String),
                contentJson: Value(msgData['contentJson'] as String),
                model: Value(msgData['model'] as String?),
                generating: Value(msgData['generating'] as bool? ?? false),
                createdAt: Value(DateTime.parse(msgData['createdAt'] as String)),
              ),
            );
            messagesCount++;
          } catch (e) {
            debugPrint('Error importing message: $e');
          }
        }
      }

      // Import AI providers (if present)
      final aiProvidersJson = data['aiProvidersJson'] as String?;
      if (aiProvidersJson != null && aiProvidersJson.isNotEmpty) {
        await _db.setSetting('ai_providers', aiProvidersJson);
      }

      return ImportResult(
        success: true,
        message: 'Imported $sessionsCount sessions and $messagesCount messages',
        sessionsCount: sessionsCount,
        messagesCount: messagesCount,
      );
    } catch (e) {
      return ImportResult(success: false, message: 'Import failed: ${e.toString()}');
    }
  }
}

class ImportResult {
  final bool success;
  final String message;
  final int sessionsCount;
  final int messagesCount;

  ImportResult({
    required this.success,
    required this.message,
    this.sessionsCount = 0,
    this.messagesCount = 0,
  });
}
