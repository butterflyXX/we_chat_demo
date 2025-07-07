// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTableInfoTable extends UserTableInfo
    with TableInfo<$UserTableInfoTable, UserTableInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserTableInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableInfoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserTableInfoTable createAlias(String alias) {
    return $UserTableInfoTable(attachedDatabase, alias);
  }
}

class UserTableInfoData extends DataClass
    implements Insertable<UserTableInfoData> {
  final int id;
  final String userId;
  final String name;
  final DateTime createdAt;
  const UserTableInfoData({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserTableInfoCompanion toCompanion(bool nullToAbsent) {
    return UserTableInfoCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory UserTableInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableInfoData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserTableInfoData copyWith({
    int? id,
    String? userId,
    String? name,
    DateTime? createdAt,
  }) => UserTableInfoData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  UserTableInfoData copyWithCompanion(UserTableInfoCompanion data) {
    return UserTableInfoData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableInfoData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableInfoData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class UserTableInfoCompanion extends UpdateCompanion<UserTableInfoData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const UserTableInfoCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserTableInfoCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    required DateTime createdAt,
  }) : userId = Value(userId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<UserTableInfoData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserTableInfoCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return UserTableInfoCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableInfoCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTableInfoTable userTableInfo = $UserTableInfoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userTableInfo];
}

typedef $$UserTableInfoTableCreateCompanionBuilder =
    UserTableInfoCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      required DateTime createdAt,
    });
typedef $$UserTableInfoTableUpdateCompanionBuilder =
    UserTableInfoCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<DateTime> createdAt,
    });

class $$UserTableInfoTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableInfoTable> {
  $$UserTableInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserTableInfoTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableInfoTable> {
  $$UserTableInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserTableInfoTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableInfoTable> {
  $$UserTableInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserTableInfoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTableInfoTable,
          UserTableInfoData,
          $$UserTableInfoTableFilterComposer,
          $$UserTableInfoTableOrderingComposer,
          $$UserTableInfoTableAnnotationComposer,
          $$UserTableInfoTableCreateCompanionBuilder,
          $$UserTableInfoTableUpdateCompanionBuilder,
          (
            UserTableInfoData,
            BaseReferences<
              _$AppDatabase,
              $UserTableInfoTable,
              UserTableInfoData
            >,
          ),
          UserTableInfoData,
          PrefetchHooks Function()
        > {
  $$UserTableInfoTableTableManager(_$AppDatabase db, $UserTableInfoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserTableInfoCompanion(
                id: id,
                userId: userId,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                required DateTime createdAt,
              }) => UserTableInfoCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserTableInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTableInfoTable,
      UserTableInfoData,
      $$UserTableInfoTableFilterComposer,
      $$UserTableInfoTableOrderingComposer,
      $$UserTableInfoTableAnnotationComposer,
      $$UserTableInfoTableCreateCompanionBuilder,
      $$UserTableInfoTableUpdateCompanionBuilder,
      (
        UserTableInfoData,
        BaseReferences<_$AppDatabase, $UserTableInfoTable, UserTableInfoData>,
      ),
      UserTableInfoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableInfoTableTableManager get userTableInfo =>
      $$UserTableInfoTableTableManager(_db, _db.userTableInfo);
}
