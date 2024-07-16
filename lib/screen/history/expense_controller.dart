import 'package:get/get.dart';
import 'package:expense_tracker/generated/assets.dart';
import 'package:expense_tracker/screen/history/expense_model.dart';

class ExpenseController extends GetxController {
  RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;
  RxList<double> weeklySummary =
      [80.40, 180.50, 70.0, 52.9, 90.8, 150.5, 100.8].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    expenseList.addAll([
      ExpenseModel(
          id: 1,
          name: 'Bus Fee',
          icon: Assets.imagesTypeyourcharge,
          amount: 25000,
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 2,
          name: 'Breakfast',
          icon: Assets.imagesTypeyourcharge,
          amount: 50000,
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 3,
          name: 'lunch',
          icon: Assets.imagesTypeyourcharge,
          amount: 80000,
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 4,
          name: 'dinner',
          icon: Assets.imagesTypeyourcharge,
          amount: 15000,
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 5,
          name: 'Snack',
          icon: Assets.imagesTypeyourcharge,
          amount: 30000,
          isDelete: false,
          isShow: true),
      ExpenseModel(
          id: 1,
          name: 'Other expense',
          icon: Assets.imagesTypeyourcharge,
          amount: 50000,
          isDelete: false,
          isShow: true),
    ]);
  }
}
