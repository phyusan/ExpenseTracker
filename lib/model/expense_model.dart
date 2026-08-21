import 'package:flutter/material.dart';

class ExpenseModel {
  final int id;
  final String name;
  final String category;
  final IconData icon;
  final Color color;
  final int amount;
  final DateTime date;
  final bool isDelete;
  final bool isShow;
  ExpenseModel({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
    required this.amount,
    required this.date,
    required this.isDelete,
    required this.isShow,
  });
}
