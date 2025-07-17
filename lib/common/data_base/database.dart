import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class UserTableInfo extends Table {
  TextColumn get userId => text()();
  TextColumn get loginUserId => text()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  IntColumn get createdAt => integer()();
  TextColumn get lastMessage => text().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {userId};
}

class MessageTable extends Table {
  TextColumn get messageId => text()();
  TextColumn get loginUserId => text()();
  TextColumn get senderId => text()();
  TextColumn get receiverId => text()();
  TextColumn get content => text()();
  TextColumn get messageType => text()();
  IntColumn get timestamp => integer()();
  @override
  Set<Column<Object>>? get primaryKey => {messageId};
}

@DriftDatabase(tables: [UserTableInfo, MessageTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());
  @override
  int get schemaVersion => 3;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
