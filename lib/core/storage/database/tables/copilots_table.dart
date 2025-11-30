import 'package:drift/drift.dart';

class Copilots extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get picUrl => text().nullable()();
  TextColumn get prompt => text()();
  BoolColumn get starred => boolean().withDefault(const Constant(false))();
  IntColumn get usedCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
