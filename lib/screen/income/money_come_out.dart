import 'package:expense_tracker/controller/base_controller.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/controller/money_come_out_controller.dart';
import 'package:expense_tracker/helper/extensions.dart';

import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/screen/income/expense.dart';
import 'package:expense_tracker/screen/income/income.dart';

class MoneyComeAndOutScreen extends StatelessWidget {
  MoneyComeAndOutScreen({super.key, required this.db});
  final AppDatabase db;
  late final MoneyComeOutController _moneyComeOutController =
      Get.put(MoneyComeOutController(db: db));

  void _goToHistory() {
    Get.find<BaseController>().currentIndex.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorPageBackground,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: _buildOverviewCard(),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(_buildTabBar()),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _moneyComeOutController.controller,
            children: [
              ExpenseScreen(),
              IncomeScreen(),
            ],
          ),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _moneyComeOutController.controller,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: MyColor.colorTransparent,
      indicator: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff18A87B), Color(0xff0D9488)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      labelColor: MyColor.colorWhite,
      labelStyle: const TextStyle(
        fontSize: FontSize.textSizeNormal,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelColor: MyColor.colorTextHint,
      tabs: const [
        Tab(
          child: Text(
            'Expense',
            style: TextStyle(
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Income',
            style: TextStyle(
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff18A87B), Color(0xff0D9488)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: FontSize.textSizeSmall,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.textSizeExtraNormal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFBD12),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Total Balance',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: FontSize.textSizeNormal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            2450000.formatAmount(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.textSizeExtraXLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildBalanceChip(
                icon: Icons.arrow_upward,
                label: 'Income',
                value: 1250000.formatAmount(),
              ),
              const SizedBox(width: 10),
              _buildBalanceChip(
                icon: Icons.arrow_downward,
                label: 'Expense',
                value: 800000.formatAmount(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: FontSize.textSizeLessSmall,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.textSizeSmall,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    const data = [45.0, 70.0, 55.0, 85.0, 50.0, 75.0, 62.0];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Overview',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.textSizeNormalReaderView,
                  color: MyColor.colorNeutral900,
                ),
              ),
              GestureDetector(
                onTap: _goToHistory,
                child: const Row(
                  children: [
                    Text(
                      'See details',
                      style: TextStyle(
                        color: MyColor.colorPrimary,
                        fontSize: FontSize.textSizeSmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: MyColor.colorPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final h = (data[i] / maxVal) * 78;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: h,
                          decoration: BoxDecoration(
                            gradient: i == 3
                                ? const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xff128A65),
                                      Color(0xff2BD9A4),
                                    ],
                                  )
                                : const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xff18A87B),
                                      Color(0xff7CE0BC),
                                    ],
                                  ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          days[i],
                          style: const TextStyle(
                            color: MyColor.colorTextHint,
                            fontSize: FontSize.textSizeLessSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  static const double _outerTop = 12;
  static const double _outerBottom = 10;
  static const double _padding = 4;

  @override
  double get minExtent =>
      _tabBar.preferredSize.height + _padding * 2 + _outerTop + _outerBottom;
  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MyColor.colorPageBackground,
      padding: const EdgeInsets.only(top: _outerTop, bottom: _outerBottom),
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(_padding),
        decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0D9488).withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
