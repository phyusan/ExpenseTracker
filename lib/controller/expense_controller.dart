import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/model/expense_model.dart';

class ExpenseController extends GetxController {
  RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;
  RxList<double> weeklySummary = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
    weeklySummary.addAll([80.40, 180.50, 70.0, 52.9, 90.8, 150.5, 100.8]);

    final now = DateTime.now();
    expenseList.addAll([
      ExpenseModel(
          id: 1,
          name: 'Bus Fee',
          category: 'Transport',
          icon: Icons.directions_bus_filled,
          color: const Color(0xff3B82F6),
          amount: 25000,
          date: now.subtract(const Duration(hours: 2)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 2,
          name: 'Breakfast',
          category: 'Food',
          icon: Icons.fastfood,
          color: const Color(0xffF59E0B),
          amount: 50000,
          date: now.subtract(const Duration(hours: 4)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 3,
          name: 'Lunch',
          category: 'Food',
          icon: Icons.lunch_dining,
          color: const Color(0xffF59E0B),
          amount: 80000,
          date: now.subtract(const Duration(days: 1, hours: 3)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 4,
          name: 'Dinner',
          category: 'Food',
          icon: Icons.dinner_dining,
          color: const Color(0xffF59E0B),
          amount: 15000,
          date: now.subtract(const Duration(days: 1)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 5,
          name: 'Snack',
          category: 'Food',
          icon: Icons.icecream,
          color: const Color(0xffF59E0B),
          amount: 30000,
          date: now.subtract(const Duration(days: 2)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 6,
          name: 'Shopping',
          category: 'Shopping',
          icon: Icons.shopping_bag,
          color: const Color(0xff8B5CF6),
          amount: 120000,
          date: now.subtract(const Duration(days: 2, hours: 5)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 7,
          name: 'Electricity Bill',
          category: 'Utilities',
          icon: Icons.bolt,
          color: const Color(0xffF97316),
          amount: 45000,
          date: now.subtract(const Duration(days: 3)),
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 8,
          name: 'Movie',
          category: 'Entertainment',
          icon: Icons.movie,
          color: const Color(0xffEF4444),
          amount: 25000,
          date: now.subtract(const Duration(days: 4)),
          isDelete: false,
          isShow: true),
    ]);
  }

  double get totalAmount =>
      expenseList.fold(0.0, (sum, item) => sum + item.amount);
}
