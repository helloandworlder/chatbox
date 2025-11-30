import 'package:drift/drift.dart';

/// MCP 服务器配置表
class McpServers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  TextColumn get transportJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
