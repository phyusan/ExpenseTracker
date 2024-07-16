import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/history/bar_graph.dart';
import 'package:expense_tracker/screen/history/expense_controller.dart';

class BarChartScreen extends StatelessWidget {
  BarChartScreen({super.key, required this.db});
  final ExpenseController _expenseController = Get.put(ExpenseController());
  final AppDatabase db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense History BarChart"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  child: MyBarGraph(
                    weeklySummary: _expenseController.weeklySummary,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: MyColor.colorBlue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: MyColor.colorTextFieldBorder)),
                    child: const Text(
                      "Total Expense Chart",
                      style: TextStyle(color: MyColor.colorWhite),
                    )),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _expenseController.expenseList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: const Icon(
                        Icons.car_crash,
                        size: 24,
                        color: MyColor.colorBlue,
                      ),
                      title: Text(
                        _expenseController.expenseList[i].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        _expenseController.expenseList[i].amount.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.textSizeLarge),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
