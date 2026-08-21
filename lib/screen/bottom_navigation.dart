import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/base_controller.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/daily_expense/add_expense.dart';
import 'package:expense_tracker/screen/history/bar_chart.dart';
import 'package:expense_tracker/screen/income/money_come_out.dart';
import 'package:expense_tracker/screen/settings/profile_setting.dart';

import '../generated/assets.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({
    Key? key,
    required this.db,
  }) : super(key: key);

  final AppDatabase db;
  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<Widget> _list = [];
  final _baseController = Get.put(BaseController());

  @override
  void initState() {
    _list = [
      MoneyComeAndOutScreen(db: widget.db),
      BarChartScreen(db: widget.db),
      AddExpenseScreen(db: widget.db),
      ProfileSettingScreen(db: widget.db),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _baseController.currentIndex.value == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _baseController.currentIndex.value = 0;
        }
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: MyColor.colorPageBackground,
          body: IndexedStack(
            index: _baseController.currentIndex.value,
            children: _list,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, 'Home', Assets.imagesHomefilledicon, Assets.imagesHomeicon),
                    _buildNavItem(1, 'History', null, null, icon: Icons.history_rounded),
                    _buildNavItem(2, 'Transaction', Assets.imagesAddicon, Assets.imagesAddicon),
                    _buildNavItem(3, 'Setting', Assets.imagesSetting, Assets.imagesSetting),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String? activeAsset,
      String? inactiveAsset, {IconData? icon}) {
    final isSelected = _baseController.currentIndex.value == index;
    return GestureDetector(
      onTap: () {
        _baseController.currentIndex.value = index;
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.colorPrimaryGreenTint : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 22,
                      color: isSelected
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                    )
                  : Image.asset(
                      isSelected ? activeAsset! : inactiveAsset!,
                      width: 22,
                      height: 22,
                      color: isSelected
                          ? MyColor.colorPrimary
                          : MyColor.colorTextHint,
                    ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? MyColor.colorPrimary
                    : MyColor.colorTextHint,
              ),
              child: Text(label, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
