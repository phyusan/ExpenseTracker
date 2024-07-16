import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/base_controller.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/daily_expense/add_expense.dart';
import 'package:expense_tracker/screen/history/bar_chart.dart';
import 'package:expense_tracker/screen/income/money_come_out.dart';
import 'package:expense_tracker/screen/manageSchedule/manage_schedule.dart';

import '../generated/assets.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  //RxInt currentIndex = 2.obs;
  const BottomNavigationBarScreen({
    Key? key,
    required this.db,
    //required this.currentIndex,
  }) : super(key: key);

  final AppDatabase db;
  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<Widget> _list = [];
  final _baseController = Get.put(BaseController());

  var count = 0;

  @override
  void initState() {
    // TODO: implement initState
    _list = [
      MoneyComeAndOutScreen(
        db: widget.db,
      ),
      BarChartScreen( db: widget.db,),
       AddExpenseScreen( db: widget.db,),
      ManageSchedule( db: widget.db,)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_baseController.currentIndex.value != 0) {
          setState(() {
            _baseController.currentIndex.value = 0;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: MyColor.colorWhite,
          body: Obx(
            () => IndexedStack(
              index: _baseController.currentIndex.value,
              children: _list,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: MyColor.colorPrimary,
              unselectedItemColor: MyColor.colorTextHint,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: _baseController.currentIndex.value,
              onTap: (i) async {
                setState(() {
                  _baseController.currentIndex.value = i;
                });

                if (_baseController.currentIndex.value == 1) {
                  if (count < 2) {
                    count++;
                  }
                } else {
                  count = 0;
                }
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(
                      Assets.imagesHomefilledicon,
                      color: _baseController.currentIndex.value == 0
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(
                      Assets.imagesHomeicon,
                      color: _baseController.currentIndex.value == 0
                          ? MyColor.colorTextBlack
                          : MyColor.colorTextHint,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Icon(
                      Icons.bar_chart,
                      color: _baseController.currentIndex.value == 1
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                      size: 24,
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Icon(
                      Icons.bar_chart,
                      color: _baseController.currentIndex.value == 1
                          ? MyColor.colorTextBlack
                          : MyColor.colorTextHint,
                      size: 24,
                    ),
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(
                      Assets.imagesAddicon,
                      color: _baseController.currentIndex.value == 2
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Image.asset(
                          Assets.imagesAddicon,
                          color: _baseController.currentIndex.value == 2
                              ? MyColor.colorTextBlack
                              : MyColor.colorTextHint,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      if (_baseController.isNotification.isTrue) ...[
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Image.asset(
                            Assets.imagesNotidot,
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ],
                    ],
                  ),
                  label: 'Transcation',
                ),
                BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(
                      Assets.imagesSetting,
                      color: _baseController.currentIndex.value == 3
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Image.asset(
                          Assets.imagesSetting,
                          color: _baseController.currentIndex.value == 3
                              ? MyColor.colorTextBlack
                              : MyColor.colorTextHint,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      if (_baseController.isNotification.isTrue) ...[
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Image.asset(
                            Assets.imagesNotidot,
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ],
                    ],
                  ),
                  label: 'Setting',
                ),
              ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
