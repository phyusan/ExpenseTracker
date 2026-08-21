import 'package:flutter/material.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/helper/extensions.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  static const Map<String, double> _categoryAmounts = {
    'Breakfast': 128000,
    'Lunch': 96000,
    'House': 92000,
    'Transport': 78000,
    'Dinner': 64000,
    'Health': 31000,
    'Clothing': 24000,
    'Cosmetic': 15000,
    'Other': 12000,
  };
  static const double _monthlyBudget = 785000;

  static const Map<String, IconData> _categoryIcons = {
    'House': Icons.home_outlined,
    'Transport': Icons.directions_car_outlined,
    'Breakfast': Icons.free_breakfast_outlined,
    'Lunch': Icons.lunch_dining_outlined,
    'Dinner': Icons.dinner_dining_outlined,
    'Health': Icons.favorite_outline,
    'Other': Icons.category_outlined,
    'Clothing': Icons.checkroom_outlined,
    'Cosmetic': Icons.face_outlined,
  };

  static const Map<String, Color> _categoryColors = {
    'House': MyColor.colorBlueLightBg,
    'Transport': MyColor.colorPinkLightBg,
    'Breakfast': MyColor.colorRed100,
    'Lunch': MyColor.colorBlueLightBg,
    'Dinner': MyColor.colorBlueLightBg,
    'Health': MyColor.colorBlueLightBg,
    'Other': MyColor.colorGreyLight,
    'Clothing': MyColor.colorBlueLightBg,
    'Cosmetic': MyColor.colorPinkLightBg,
  };

  double get _totalSpent =>
      _categoryAmounts.values.fold(0, (sum, v) => sum + v);

  List<MapEntry<String, double>> get _rankedCategories {
    final list = _categoryAmounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return list;
  }

  double _percentOf(double amount) =>
      _totalSpent == 0 ? 0 : (amount / _totalSpent) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Expense Card
              Container(
                decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 185, 182, 182)
                          .withValues(alpha: 0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "March Savings",
                        style: TextStyle(
                          color: MyColor.colorBlackSemiTransparent,
                          fontSize: FontSize.textSizeSmall,
                        ),
                      ),
                      const Text(
                        "23,430,000 Ks",
                        style: TextStyle(
                          color: MyColor.colorBlackSemiTransparent,
                          fontSize: FontSize.textSizeExtraLarge,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColor.colorGreyLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 210,
                                decoration: BoxDecoration(
                                    color: MyColor.colorBlue.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 3),
                                  child: Text(
                                    "Earned",
                                    style: TextStyle(
                                        color: MyColor.colorWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            const Positioned(
                              right: 20,
                              top: 3,
                              child: Text(
                                '20,5000 Ks',
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColor.colorGreyLight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color:
                                        MyColor.colorTextRed.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 3),
                                  child: Text(
                                    "Spend",
                                    style: TextStyle(
                                        color: MyColor.colorWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            const Positioned(
                              right: 20,
                              top: 3,
                              child: Text(
                                '10,5000 Ks',
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Top Spending',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.textSizeLarge),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 156,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _rankedCategories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final entry = _rankedCategories[i];
                    final name = entry.key;
                    final amount = entry.value;
                    final percent = _percentOf(amount);
                    return Container(
                      width: 148,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff0D9488)
                                .withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: MyColor.colorPrimary
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '#${i + 1}',
                                  style: const TextStyle(
                                    color: MyColor.colorPrimary,
                                    fontSize: FontSize.textSizeSmall,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _categoryColors[name] ??
                                      MyColor.colorBlueLightBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  _categoryIcons[name] ??
                                      Icons.category_outlined,
                                  size: 18,
                                  color: MyColor.colorPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: MyColor.colorNeutral900,
                              fontSize: FontSize.textSizeNormal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            amount.formatAmount(),
                            style: const TextStyle(
                              color: MyColor.colorTextBlack800,
                              fontSize: FontSize.textSizeSmall,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percent / 100,
                              minHeight: 4,
                              backgroundColor: MyColor.colorGreyLight,
                              valueColor: const AlwaysStoppedAnimation(
                                  MyColor.colorPrimary),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${percent.toStringAsFixed(0)}% of budget',
                            style: const TextStyle(
                              color: MyColor.colorTextHint,
                              fontSize: FontSize.textSizeLessSmall,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Monthly Budget",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.textSizeLarge),
              ),
              const SizedBox(
                height: 12,
              ),
              _buildMonthlyBudget(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyBudget() {
    final spentPercent = _monthlyBudget == 0
        ? 0.0
        : (_totalSpent / _monthlyBudget).clamp(0.0, 1.0);
    final remaining = (_monthlyBudget - _totalSpent) < 0
        ? 0.0
        : _monthlyBudget - _totalSpent;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(18),
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
                'Monthly Budget',
                style: TextStyle(
                  color: MyColor.colorNeutral900,
                  fontSize: FontSize.textSizeNormalReaderView,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _monthlyBudget.formatAmount(),
                style: const TextStyle(
                  color: MyColor.colorPrimary,
                  fontSize: FontSize.textSizeNormal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Spent ${_totalSpent.formatAmount()} of ${_monthlyBudget.formatAmount()}',
            style: const TextStyle(
              color: MyColor.colorTextBlack800,
              fontSize: FontSize.textSizeSmall,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: spentPercent,
              minHeight: 8,
              backgroundColor: MyColor.colorGreyLight,
              valueColor:
                  const AlwaysStoppedAnimation(MyColor.colorPrimary),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining ${remaining.formatAmount()}',
                style: const TextStyle(
                  color: MyColor.colorTextHint,
                  fontSize: FontSize.textSizeLessSmall,
                ),
              ),
              Text(
                '${(spentPercent * 100).round()}%',
                style: const TextStyle(
                  color: MyColor.colorPrimary,
                  fontSize: FontSize.textSizeLessSmall,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: MyColor.colorDivider, height: 1),
          const SizedBox(height: 12),
          ..._categoryAmounts.entries.map((entry) {
            final amount = entry.value;
            final ratio = _monthlyBudget == 0
                ? 0.0
                : (amount / _monthlyBudget).clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _categoryColors[entry.key] ??
                              MyColor.colorBlueLightBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _categoryIcons[entry.key] ??
                              Icons.category_outlined,
                          size: 16,
                          color: MyColor.colorPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          entry.key,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MyColor.colorNeutral900,
                            fontSize: FontSize.textSizeSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        amount.formatAmount(),
                        style: const TextStyle(
                          color: MyColor.colorTextBlack800,
                          fontSize: FontSize.textSizeSmall,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: ratio,
                      minHeight: 5,
                      backgroundColor: MyColor.colorGreyLight,
                      valueColor: const AlwaysStoppedAnimation(
                          MyColor.colorPrimary),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
