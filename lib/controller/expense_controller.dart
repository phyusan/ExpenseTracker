import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/model/category_model.dart';
import 'package:expense_tracker/screen/income/income.dart';

class ExpendController extends GetxController {
  Rx<TextEditingController> incomeTextController = TextEditingController().obs;
  RxList<CategoryModel> spendingCategoryList = <CategoryModel>[].obs;
  var isConvert = false.obs;
  var payIncome = (0.0).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    spendingCategoryList.addAll([
      CategoryModel(
          id: 1,
          name: 'House',
          description: 'House',
          containerColor: MyColor.colorGreen,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 2,
          name: 'Transport',
          description: 'Transport',
          containerColor: MyColor.colorRedTransparent,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 3,
          name: 'Breakfast',
          description: 'Breakfast',
          containerColor: MyColor.colorTextRed,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 4,
          name: 'lunch',
          description: 'Lunch',
          containerColor: MyColor.colorBlue,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 5,
          name: 'Dinner',
          description: 'Dinner',
          containerColor: MyColor.colorGreen,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 6,
          name: 'Health',
          description: 'Health',
          containerColor: MyColor.colorGreen,
          isDisable: false.obs,
          isSelect: false.obs),
      CategoryModel(
          id: 7,
          name: 'Other',
          description: 'Other',
          containerColor: MyColor.colorGreen,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 8,
          name: 'Clothing',
          description: 'Clothing',
          containerColor: MyColor.colorGreen,
          isDisable: false.obs,
          isSelect: true.obs),
      CategoryModel(
          id: 9,
          name: 'Cosmetic',
          description: 'Cosmetic',
          containerColor: MyColor.colorRedTransparent,
          isDisable: false.obs,
          isSelect: false.obs),
    ]);
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
