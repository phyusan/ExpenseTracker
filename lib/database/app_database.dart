import 'dart:async';
import 'package:expense_tracker/database/dao/expense_dao.dart';
import 'package:expense_tracker/model/fcm_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 2, entities: [
  FcmModel,
])
abstract class AppDatabase extends FloorDatabase {
  ExpenseDao get expenseDao;
  static Future<AppDatabase> init() async {
    var db = await $FloorAppDatabase.databaseBuilder('Expense')
        .addMigrations([_migration1to2])
        .build();
    return db;
  }
}

final _migration1to2 = Migration(1, 2, (database) async {
  await database.execute('ALTER TABLE Account ADD COLUMN category TEXT');
  await database.execute('ALTER TABLE Account ADD COLUMN createdAt INTEGER');
});
