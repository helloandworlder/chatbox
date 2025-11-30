import 'package:drift/drift.dart';

class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text().withDefault(const Constant('chat'))();
  BoolColumn get starred => boolean().withDefault(const Constant(false))();
  TextColumn get copilotId => text().nullable()();
  TextColumn get settingsJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
