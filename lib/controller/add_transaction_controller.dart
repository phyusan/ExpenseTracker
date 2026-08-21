import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/model/fcm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  final AppDatabase db;
  AddTransactionController({required this.db});

  final RxList<FcmModel> transactions = <FcmModel>[].obs;
  final searchController = TextEditingController().obs;
  final isLoading = false.obs;

  double get balance {
    double income = 0;
    double outcome = 0;
    for (final t in transactions) {
      income += double.tryParse(t.incomeAmount ?? '') ?? 0;
      outcome += double.tryParse(t.outcomeAmount ?? '') ?? 0;
    }
    return income - outcome;
  }

  double get totalIncome {
    double income = 0;
    for (final t in transactions) {
      income += double.tryParse(t.incomeAmount ?? '') ?? 0;
    }
    return income;
  }

  double get totalOutcome {
    double outcome = 0;
    for (final t in transactions) {
      outcome += double.tryParse(t.outcomeAmount ?? '') ?? 0;
    }
    return outcome;
  }

  List<FcmModel> get filteredTransactions {
    final keyword = searchController.value.text.trim();
    if (keyword.isEmpty) {
      return transactions;
    }
    return transactions
        .where((t) =>
            (t.name ?? '').toLowerCase().contains(keyword.toLowerCase()) ||
            (t.category ?? '').toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  List<FcmModel> get todayTransactions {
    final now = DateTime.now();
    return transactions.where((t) {
      final d = _dateOf(t);
      return d != null &&
          d.year == now.year &&
          d.month == now.month &&
          d.day == now.day;
    }).toList();
  }

  List<FcmModel> get weekTransactions {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    return transactions.where((t) {
      final d = _dateOf(t);
      return d != null && !d.isBefore(start);
    }).toList();
  }

  List<FcmModel> get monthTransactions {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    return transactions.where((t) {
      final d = _dateOf(t);
      return d != null && !d.isBefore(start);
    }).toList();
  }

  double incomeOf(List<FcmModel> list) {
    double income = 0;
    for (final t in list) {
      income += double.tryParse(t.incomeAmount ?? '') ?? 0;
    }
    return income;
  }

  double outcomeOf(List<FcmModel> list) {
    double outcome = 0;
    for (final t in list) {
      outcome += double.tryParse(t.outcomeAmount ?? '') ?? 0;
    }
    return outcome;
  }

  DateTime? _dateOf(FcmModel t) {
    final ts = t.createdAt;
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    searchController.value.addListener(transactions.refresh);
  }

  Future<void> loadTransactions() async {
    isLoading.value = true;
    transactions.value = await db.expenseDao.findAllPersons();
    isLoading.value = false;
  }

  Future<void> addTransaction({
    required String name,
    required String amount,
    required bool isIncome,
    required String category,
    int? createdAt,
  }) async {
    await db.expenseDao.insertAccount(FcmModel(
      name: name,
      category: category,
      createdAt: createdAt ?? DateTime.now().millisecondsSinceEpoch,
      incomeAmount: isIncome ? amount : null,
      outcomeAmount: isIncome ? null : amount,
    ));
    await loadTransactions();
  }

  Future<void> deleteTransaction(FcmModel model) async {
    await db.expenseDao.deleteById(model.id!);
    await loadTransactions();
  }

  @override
  void onClose() {
    searchController.value.removeListener(transactions.refresh);
    super.onClose();
  }
}
