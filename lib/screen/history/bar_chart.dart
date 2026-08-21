import 'package:expense_tracker/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/helper/extensions.dart';
import 'package:expense_tracker/screen/history/bar_graph.dart';
import 'package:expense_tracker/controller/expense_controller.dart';
import 'package:expense_tracker/model/expense_model.dart';

class BarChartScreen extends StatefulWidget {
  const BarChartScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  final ExpenseController _expenseController = Get.put(ExpenseController());
  int _selectedPeriod = 0;

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    if (day == today) return 'Today, ${DateFormat('h:mm a').format(date)}';
    if (day == today.subtract(const Duration(days: 1))) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    }
    return DateFormat('d MMM, h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorPageBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildPeriodToggle(),
                    const SizedBox(height: 20),
                    _buildChartCard(),
                    const SizedBox(height: 16),
                    _buildStatsRow(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.textSizeExtraNormal,
                            color: MyColor.colorNeutral900,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: MyColor.colorPrimary,
                          ),
                          child: const Text(
                            'See all',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildTransactionList(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Positioned(
          right: -50,
          top: -70,
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: -20,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 34),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff18A87B), Color(0xff0D9488)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Expense History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.textSizeLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                'Total Spent',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: FontSize.textSizeNormal,
                ),
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  _expenseController.totalAmount.formatAmount(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.textSizeExtraXLarge,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _headerPill(
                    icon: Icons.trending_up,
                    text: '+12.5% vs last month',
                  ),
                  const SizedBox(width: 10),
                  _headerPill(
                    icon: Icons.calendar_today_outlined,
                    text: DateFormat('MMMM yyyy').format(DateTime.now()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerPill({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.textSizeSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _periodTab('Week', 0),
          _periodTab('Month', 1),
        ],
      ),
    );
  }

  Widget _periodTab(String label, int index) {
    final selected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? MyColor.colorPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : MyColor.colorTextHint,
              fontWeight: FontWeight.w600,
              fontSize: FontSize.textSizeNormal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedPeriod == 0 ? 'Weekly Spending' : 'Monthly Spending',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.textSizeNormalReaderView,
                  color: MyColor.colorNeutral900,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: MyColor.colorPrimaryGreenTint,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  _selectedPeriod == 0 ? 'This Week' : 'This Month',
                  style: const TextStyle(
                    color: MyColor.colorPrimary,
                    fontSize: FontSize.textSizeSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(
              '${_expenseController.totalAmount.formatAmount()} spent '
              '${_selectedPeriod == 0 ? 'this week' : 'this month'}',
              style: const TextStyle(
                color: MyColor.colorTextHint,
                fontSize: FontSize.textSizeSmall,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 210,
            child: Obx(
              () => MyBarGraph(
                weeklySummary: _expenseController.weeklySummary.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Obx(
      () {
        final total = _expenseController.totalAmount;
        final count = _expenseController.expenseList.length;
        return Row(
          children: [
            _statCard(
              color: MyColor.colorPrimary,
              icon: Icons.account_balance_wallet_outlined,
              label: 'Total',
              value: total.formatAmount(),
            ),
            const SizedBox(width: 12),
            _statCard(
              color: const Color(0xffF59E0B),
              icon: Icons.trending_down,
              label: 'Avg / Day',
              value: (total / 7).formatAmount(),
            ),
            const SizedBox(width: 12),
            _statCard(
              color: const Color(0xff8B5CF6),
              icon: Icons.receipt_long_outlined,
              label: 'Txns',
              value: count.toString(),
            ),
          ],
        );
      },
    );
  }

  Widget _statCard({
    required Color color,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0D9488).withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: MyColor.colorTextHint,
                fontSize: FontSize.textSizeLessSmall,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: MyColor.colorNeutral900,
                fontSize: FontSize.textSizeSmall,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Obx(
      () => Column(
        children: List.generate(
          _expenseController.expenseList.length,
          (i) => _transactionTile(_expenseController.expenseList[i]),
        ),
      ),
    );
  }

  Widget _transactionTile(ExpenseModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D9488).withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: item.color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColor.colorNeutral900,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.textSizeNormalReaderView,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.category} \u2022 ${_formatDate(item.date)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColor.colorTextHint,
                    fontSize: FontSize.textSizeSmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-${item.amount.toDouble().formatAmount()}',
                style: const TextStyle(
                  color: MyColor.colorTextRed,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.textSizeSmall,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                DateFormat('dd/MM').format(item.date),
                style: const TextStyle(
                  color: MyColor.colorTextHint,
                  fontSize: FontSize.textSizeLessSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
