import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/income_controller.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class IncomeScreen extends StatelessWidget {
  IncomeScreen({super.key});
  final IncomeController _incomeController = Get.put(IncomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: _incomeController.incomeTextController.value,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please Income Amount',
                  hintStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _incomeController.isConvert(true);

              if (_incomeController
                  .incomeTextController.value.text.isNotEmpty) {
                _incomeController.convertMoney();
              }
              print("Convert::${_incomeController.isConvert}");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: MyColor.colorBlue)),
              child: const Text('Convert'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_incomeController.isConvert.isTrue) ...[
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                          color: MyColor.colorBlue,
                        )),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: const Text("Income Money")),
                            Text(_incomeController
                                .incomeTextController.value.text),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                          color: MyColor.colorBlue,
                        )),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: const Text("Average daily Money")),
                            Text(_incomeController.payIncome
                                .truncate()
                                .toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      )),
    );
  }
}

extension DaysInMonthExtension on DateTime {
  int get daysInMonth {
    return DateTime(year, month + 1, 1)
        .difference(DateTime(year, month, 1))
        .inDays;
  }
}
