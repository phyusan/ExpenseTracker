import 'dart:async';
import 'package:expense_tracker/database/dao/expense_dao.dart';
import 'package:expense_tracker/database/dao/expense_dao.dart';
import 'package:expense_tracker/model/fcm_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:json_annotation/json_annotation.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [
  FcmModel,
])
abstract class AppDatabase extends FloorDatabase {
  ExpenseDao get expenseDao;
  static Future<AppDatabase> init() async {
    var db = await $FloorAppDatabase.databaseBuilder('Expense').build();
    return db;
  }
}
