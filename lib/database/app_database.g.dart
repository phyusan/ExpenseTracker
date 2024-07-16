// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpenseDao? _expenseDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Account` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `phone` INTEGER, `incomeAmount` TEXT, `outcomeAmount` TEXT, `PhotoURL` TEXT, `isRead` INTEGER, `isNew` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpenseDao get expenseDao {
    return _expenseDaoInstance ??= _$ExpenseDao(database, changeListener);
  }
}

class _$ExpenseDao extends ExpenseDao {
  _$ExpenseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _fcmModelInsertionAdapter = InsertionAdapter(
            database,
            'Account',
            (FcmModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'incomeAmount': item.incomeAmount,
                  'outcomeAmount': item.outcomeAmount,
                  'PhotoURL': item.PhotoURL,
                  'isRead': item.isRead,
                  'isNew': item.isNew == null ? null : (item.isNew! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FcmModel> _fcmModelInsertionAdapter;

  @override
  Future<List<FcmModel>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Account',
        mapper: (Map<String, Object?> row) => FcmModel(
            id: row['id'] as int?,
            name: row['name'] as String?,
            phone: row['phone'] as int?,
            incomeAmount: row['incomeAmount'] as String?,
            outcomeAmount: row['outcomeAmount'] as String?,
            PhotoURL: row['PhotoURL'] as String?,
            isRead: row['isRead'] as int?,
            isNew: row['isNew'] == null ? null : (row['isNew'] as int) != 0));
  }

  @override
  Future<List<FcmModel>?> getNotiById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Account WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FcmModel(
            id: row['id'] as int?,
            name: row['name'] as String?,
            phone: row['phone'] as int?,
            incomeAmount: row['incomeAmount'] as String?,
            outcomeAmount: row['outcomeAmount'] as String?,
            PhotoURL: row['PhotoURL'] as String?,
            isRead: row['isRead'] as int?,
            isNew: row['isNew'] == null ? null : (row['isNew'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> clearDB() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Account');
  }

  @override
  Future<void> insertAccount(FcmModel person) async {
    await _fcmModelInsertionAdapter.insert(person, OnConflictStrategy.replace);
  }
}
