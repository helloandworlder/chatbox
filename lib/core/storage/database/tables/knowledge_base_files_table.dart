import 'package:drift/drift.dart';

import 'knowledge_bases_table.dart';

/// 知识库文件表
class KnowledgeBaseFiles extends Table {
  TextColumn get id => text()();
  TextColumn get knowledgeBaseId => text().references(KnowledgeBases, #id)();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  TextColumn get mimeType => text().withDefault(const Constant(''))();
  IntColumn get fileSize => integer().withDefault(const Constant(0))();
  TextColumn get indexStatus => text().withDefault(const Constant('idle'))();
  TextColumn get indexError => text().nullable()();
  IntColumn get chunkCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
