import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/sessions_table.dart';
import 'tables/messages_table.dart';
import 'tables/settings_table.dart';
import 'tables/mcp_servers_table.dart';
import 'tables/knowledge_bases_table.dart';
import 'tables/knowledge_base_files_table.dart';
import 'tables/copilots_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Sessions,
  Messages,
  Settings,
  McpServers,
  KnowledgeBases,
  KnowledgeBaseFiles,
  Copilots,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(mcpServers);
        }
        if (from < 3) {
          await m.createTable(knowledgeBases);
          await m.createTable(knowledgeBaseFiles);
        }
        if (from < 4) {
          await m.createTable(copilots);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'chatbox.db');
  }

  // ========== Sessions ==========
  Stream<List<Session>> watchAllSessions() {
    return (select(sessions)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  Stream<List<Session>> watchStarredSessions() {
    return (select(sessions)
          ..where((t) => t.starred.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  Future<Session?> getSession(String id) {
    return (select(sessions)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertSession(SessionsCompanion session) {
    return into(sessions).insert(session);
  }

  Future<bool> updateSession(SessionsCompanion session) {
    return update(sessions).replace(session);
  }

  Future<int> deleteSession(String id) {
    return (delete(sessions)..where((t) => t.id.equals(id))).go();
  }

  // ========== Messages ==========
  Stream<List<Message>> watchMessages(String sessionId) {
    return (select(messages)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }

  Future<List<Message>> getMessages(String sessionId) {
    return (select(messages)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Future<int> insertMessage(MessagesCompanion message) {
    return into(messages).insert(message);
  }

  Future<bool> updateMessage(MessagesCompanion message) {
    return update(messages).replace(message);
  }

  Future<int> deleteMessage(String id) {
    return (delete(messages)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteSessionMessages(String sessionId) {
    return (delete(messages)..where((t) => t.sessionId.equals(sessionId))).go();
  }

  // ========== Settings ==========
  Future<String?> getSetting(String key) async {
    final result = await (select(settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return result?.valueJson;
  }

  Future<void> setSetting(String key, String valueJson) {
    return into(settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: Value(key),
        valueJson: Value(valueJson),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<String?> watchSetting(String key) {
    return (select(settings)..where((t) => t.key.equals(key)))
        .watchSingleOrNull()
        .map((s) => s?.valueJson);
  }

  // ========== MCP Servers ==========
  Stream<List<McpServer>> watchAllMcpServers() {
    return (select(mcpServers)..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  Future<List<McpServer>> getAllMcpServers() {
    return (select(mcpServers)..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<McpServer?> getMcpServer(String id) {
    return (select(mcpServers)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertMcpServer(McpServersCompanion server) {
    return into(mcpServers).insert(server);
  }

  Future<bool> updateMcpServer(McpServersCompanion server) {
    return update(mcpServers).replace(server);
  }

  Future<int> deleteMcpServer(String id) {
    return (delete(mcpServers)..where((t) => t.id.equals(id))).go();
  }

  // ========== Knowledge Bases ==========
  Stream<List<KnowledgeBase>> watchAllKnowledgeBases() {
    return (select(knowledgeBases)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  Future<List<KnowledgeBase>> getAllKnowledgeBases() {
    return (select(knowledgeBases)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }

  Future<KnowledgeBase?> getKnowledgeBase(String id) {
    return (select(knowledgeBases)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertKnowledgeBase(KnowledgeBasesCompanion kb) {
    return into(knowledgeBases).insert(kb);
  }

  Future<bool> updateKnowledgeBase(KnowledgeBasesCompanion kb) {
    return update(knowledgeBases).replace(kb);
  }

  Future<int> deleteKnowledgeBase(String id) {
    return (delete(knowledgeBases)..where((t) => t.id.equals(id))).go();
  }

  // ========== Knowledge Base Files ==========
  Stream<List<KnowledgeBaseFile>> watchKnowledgeBaseFiles(
      String knowledgeBaseId) {
    return (select(knowledgeBaseFiles)
          ..where((t) => t.knowledgeBaseId.equals(knowledgeBaseId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<KnowledgeBaseFile>> getKnowledgeBaseFiles(
      String knowledgeBaseId) {
    return (select(knowledgeBaseFiles)
          ..where((t) => t.knowledgeBaseId.equals(knowledgeBaseId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<KnowledgeBaseFile?> getKnowledgeBaseFile(String id) {
    return (select(knowledgeBaseFiles)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertKnowledgeBaseFile(KnowledgeBaseFilesCompanion file) {
    return into(knowledgeBaseFiles).insert(file);
  }

  Future<bool> updateKnowledgeBaseFile(KnowledgeBaseFilesCompanion file) {
    return update(knowledgeBaseFiles).replace(file);
  }

  Future<int> deleteKnowledgeBaseFile(String id) {
    return (delete(knowledgeBaseFiles)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteAllKnowledgeBaseFiles(String knowledgeBaseId) {
    return (delete(knowledgeBaseFiles)
          ..where((t) => t.knowledgeBaseId.equals(knowledgeBaseId)))
        .go();
  }

  // ========== Copilots ==========
  Stream<List<Copilot>> watchAllCopilots() {
    return (select(copilots)
          ..orderBy([
            (t) => OrderingTerm.desc(t.starred),
            (t) => OrderingTerm.desc(t.usedCount),
          ]))
        .watch();
  }

  Future<List<Copilot>> getAllCopilots() {
    return (select(copilots)
          ..orderBy([
            (t) => OrderingTerm.desc(t.starred),
            (t) => OrderingTerm.desc(t.usedCount),
          ]))
        .get();
  }

  Future<Copilot?> getCopilot(String id) {
    return (select(copilots)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertCopilot(CopilotsCompanion copilot) {
    return into(copilots).insert(copilot);
  }

  Future<bool> updateCopilot(CopilotsCompanion copilot) {
    return update(copilots).replace(copilot);
  }

  Future<int> deleteCopilot(String id) {
    return (delete(copilots)..where((t) => t.id.equals(id))).go();
  }
}
