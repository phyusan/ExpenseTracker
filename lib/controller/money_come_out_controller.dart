import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/model/fcm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyComeOutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;
  AppDatabase db;
  MoneyComeOutController({required this.db});
  RxList<FcmModel> model = <FcmModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 2);
    getAccount();
  }

  Future<void> getAccount() async {
    // final m = await db.expenseDao.findAccount();

    // print("${m.toJson()}");
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
