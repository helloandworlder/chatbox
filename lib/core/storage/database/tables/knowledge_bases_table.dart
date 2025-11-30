import 'package:drift/drift.dart';

/// 知识库表
class KnowledgeBases extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get indexStatus => text().withDefault(const Constant('idle'))();
  TextColumn get indexError => text().nullable()();
  IntColumn get fileCount => integer().withDefault(const Constant(0))();
  IntColumn get chunkCount => integer().withDefault(const Constant(0))();
  IntColumn get embeddingDimensions => integer().withDefault(const Constant(1536))();
  TextColumn get embeddingProviderId => text().nullable()();
  TextColumn get embeddingModel => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
