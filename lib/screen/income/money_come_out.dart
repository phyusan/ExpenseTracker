import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/money_come_out_controller.dart';

import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/income/expense.dart';
import 'package:expense_tracker/screen/income/income.dart';

class MoneyComeAndOutScreen extends StatelessWidget {
  MoneyComeAndOutScreen({super.key});
  final MoneyComeOutController _moneyComeOutController =
      Get.put(MoneyComeOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverAppBar(
                titleSpacing: 0.0,
                backgroundColor: MyColor.colorBlue,
                elevation: 0,
                expandedHeight: 50,
                pinned: true,
                centerTitle: true,
                title: Text(
                  'Money Come & Out',
                  style: TextStyle(
                    fontSize: FontSize.textSizeLarge,
                    color: MyColor.colorWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _moneyComeOutController.controller,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColor.colorBlue,
                        borderRadius: BorderRadius.circular(5)),
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    labelStyle: const TextStyle(
                      color: MyColor.colorWhite,
                    ),
                    unselectedLabelStyle:
                        const TextStyle(color: MyColor.colorTextWhite),
                    unselectedLabelColor: MyColor.colorNeutral500,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Expense',
                          style: TextStyle(
                            fontSize: FontSize.textSizeNormal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Income',
                          style: TextStyle(
                            fontSize: FontSize.textSizeNormal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container(
            padding: const EdgeInsets.only(top: 30),
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _moneyComeOutController.controller,
                children: [
                  ExpenseScreen(),
                  IncomeScreen(),
                ]),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        color: MyColor.colorNeutral200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
