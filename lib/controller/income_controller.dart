import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/screen/income/income.dart';

class IncomeController extends GetxController {
  Rx<TextEditingController> incomeTextController = TextEditingController().obs;

  var isConvert = false.obs;
  var payIncome = (0.0).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void convertMoney() {
    var x = DateTime.now().daysInMonth;
    print(x);
    print('PayIncome:::${incomeTextController.value.text}');

    int income = int.parse(incomeTextController.value.text);
    payIncome = (income / x).obs;
    print('PayIncome::${payIncome.toInt()}');
  }
}
