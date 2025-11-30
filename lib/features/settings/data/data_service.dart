import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/storage/database/app_database.dart';

/// 导出选项
class ExportOptions {
  final bool sessions;      // 对话
  final bool providers;     // AI Providers
  final bool mcpServers;    // MCP 服务器
  final bool knowledgeBases; // 知识库
  final bool settings;      // 其他设置

  const ExportOptions({
    this.sessions = true,
    this.providers = true,
    this.mcpServers = true,
    this.knowledgeBases = true,
    this.settings = true,
  });

  static const all = ExportOptions();
  
  static const sessionsOnly = ExportOptions(
    sessions: true,
    providers: false,
    mcpServers: false,
    knowledgeBases: false,
    settings: false,
  );

  static const providersOnly = ExportOptions(
    sessions: false,
    providers: true,
    mcpServers: false,
    knowledgeBases: false,
    settings: false,
  );

  bool get isEmpty => !sessions && !providers && !mcpServers && !knowledgeBases && !settings;
}

class DataExportService {
  final AppDatabase _db;

  DataExportService(this._db);

  Future<Map<String, dynamic>> exportData({
    ExportOptions options = const ExportOptions(),
  }) async {
    final result = <String, dynamic>{
      'version': '2.0.0',
      'exportedAt': DateTime.now().toIso8601String(),
    };

    // Export sessions and messages
    if (options.sessions) {
      final sessions = await _getAllSessions();
      result['sessions'] = sessions;

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
      result['messages'] = allMessages;
    }

    // Export AI providers
    if (options.providers) {
      final providersJson = await _db.getSetting('ai_providers');
      result['aiProvidersJson'] = providersJson;
    }

    // Export MCP servers
    if (options.mcpServers) {
      final mcpServers = await _db.getAllMcpServers();
      result['mcpServers'] = mcpServers.map((m) => {
        'id': m.id,
        'name': m.name,
        'transportJson': m.transportJson,
        'enabled': m.enabled,
        'createdAt': m.createdAt.toIso8601String(),
      }).toList();
    }

    // Export knowledge bases
    if (options.knowledgeBases) {
      final knowledgeBases = await _db.getAllKnowledgeBases();
      result['knowledgeBases'] = knowledgeBases.map((k) => {
        'id': k.id,
        'name': k.name,
        'description': k.description,
        'embeddingDimensions': k.embeddingDimensions,
        'embeddingProviderId': k.embeddingProviderId,
        'embeddingModel': k.embeddingModel,
        'createdAt': k.createdAt.toIso8601String(),
      }).toList();
    }

    // Export other settings
    if (options.settings) {
      final appSettings = await _db.getSetting('app_settings');
      result['appSettingsJson'] = appSettings;
    }

    return result;
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

  Future<String> exportToFile({
    ExportOptions options = const ExportOptions(),
  }) async {
    final data = await exportData(options: options);
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
    final filePath = '${directory.path}/chatbox_export_$timestamp.json';

    final file = File(filePath);
    await file.writeAsString(jsonString);

    return filePath;
  }

  Future<void> shareExport({
    ExportOptions options = const ExportOptions(),
    Rect? sharePositionOrigin,
  }) async {
    final filePath = await exportToFile(options: options);
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: 'Chatbox Data Export',
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}

/// 导入预览结果
class ImportPreview {
  final int sessionsCount;
  final int messagesCount;
  final bool hasProviders;
  final bool hasMcpServers;
  final bool hasKnowledgeBases;
  final bool hasSettings;
  final String rawJson;

  ImportPreview({
    required this.sessionsCount,
    required this.messagesCount,
    required this.hasProviders,
    required this.hasMcpServers,
    required this.hasKnowledgeBases,
    required this.hasSettings,
    required this.rawJson,
  });

  bool get isEmpty =>
      sessionsCount == 0 &&
      messagesCount == 0 &&
      !hasProviders &&
      !hasMcpServers &&
      !hasKnowledgeBases &&
      !hasSettings;
}

/// 导入选项
class ImportOptions {
  final bool sessions;
  final bool providers;
  final bool mcpServers;
  final bool knowledgeBases;
  final bool settings;

  const ImportOptions({
    this.sessions = true,
    this.providers = true,
    this.mcpServers = true,
    this.knowledgeBases = true,
    this.settings = true,
  });

  static const all = ImportOptions();
}

class DataImportService {
  final AppDatabase _db;

  DataImportService(this._db);

  /// 选择文件并预览内容
  Future<ImportPreview?> pickAndPreview() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = File(result.files.first.path!);
    final content = await file.readAsString();

    return previewJson(content);
  }

  /// 预览 JSON 内容
  ImportPreview previewJson(String jsonString) {
    try {
      final data = json.decode(jsonString) as Map<String, dynamic>;

      final sessions = data['sessions'] as List<dynamic>?;
      final messages = data['messages'] as List<dynamic>?;
      final aiProvidersJson = data['aiProvidersJson'] as String?;
      final mcpServers = data['mcpServers'] as List<dynamic>?;
      final knowledgeBases = data['knowledgeBases'] as List<dynamic>?;
      final appSettingsJson = data['appSettingsJson'] as String?;

      return ImportPreview(
        sessionsCount: sessions?.length ?? 0,
        messagesCount: messages?.length ?? 0,
        hasProviders: aiProvidersJson != null && aiProvidersJson.isNotEmpty,
        hasMcpServers: mcpServers != null && mcpServers.isNotEmpty,
        hasKnowledgeBases: knowledgeBases != null && knowledgeBases.isNotEmpty,
        hasSettings: appSettingsJson != null && appSettingsJson.isNotEmpty,
        rawJson: jsonString,
      );
    } catch (e) {
      return ImportPreview(
        sessionsCount: 0,
        messagesCount: 0,
        hasProviders: false,
        hasMcpServers: false,
        hasKnowledgeBases: false,
        hasSettings: false,
        rawJson: jsonString,
      );
    }
  }

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

  Future<ImportResult> importFromJson(
    String jsonString, {
    ImportOptions options = const ImportOptions(),
  }) async {
    try {
      final data = json.decode(jsonString) as Map<String, dynamic>;
      final version = data['version'] as String?;

      if (version == null) {
        return ImportResult(success: false, message: 'Invalid export file format');
      }

      int sessionsCount = 0;
      int messagesCount = 0;

      // Import sessions
      if (options.sessions) {
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
      }

      // Import AI providers
      if (options.providers) {
        final aiProvidersJson = data['aiProvidersJson'] as String?;
        if (aiProvidersJson != null && aiProvidersJson.isNotEmpty) {
          await _db.setSetting('ai_providers', aiProvidersJson);
        }
      }

      // Import MCP servers
      if (options.mcpServers) {
        final mcpServers = data['mcpServers'] as List<dynamic>?;
        if (mcpServers != null) {
          for (final serverData in mcpServers) {
            try {
              await _db.into(_db.mcpServers).insertOnConflictUpdate(
                McpServersCompanion(
                  id: Value(serverData['id'] as String),
                  name: Value(serverData['name'] as String),
                  transportJson: Value(serverData['transportJson'] as String),
                  enabled: Value(serverData['enabled'] as bool? ?? false),
                  createdAt: Value(DateTime.parse(serverData['createdAt'] as String)),
                ),
              );
            } catch (e) {
              debugPrint('Error importing MCP server: $e');
            }
          }
        }
      }

      // Import knowledge bases
      if (options.knowledgeBases) {
        final knowledgeBases = data['knowledgeBases'] as List<dynamic>?;
        if (knowledgeBases != null) {
          for (final kbData in knowledgeBases) {
            try {
              await _db.into(_db.knowledgeBases).insertOnConflictUpdate(
                KnowledgeBasesCompanion(
                  id: Value(kbData['id'] as String),
                  name: Value(kbData['name'] as String),
                  description: Value(kbData['description'] as String?),
                  embeddingDimensions: Value(kbData['embeddingDimensions'] as int? ?? 1536),
                  embeddingProviderId: Value(kbData['embeddingProviderId'] as String?),
                  embeddingModel: Value(kbData['embeddingModel'] as String?),
                  createdAt: Value(DateTime.parse(kbData['createdAt'] as String)),
                ),
              );
            } catch (e) {
              debugPrint('Error importing knowledge base: $e');
            }
          }
        }
      }

      // Import other settings
      if (options.settings) {
        final appSettingsJson = data['appSettingsJson'] as String?;
        if (appSettingsJson != null && appSettingsJson.isNotEmpty) {
          await _db.setSetting('app_settings', appSettingsJson);
        }
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
