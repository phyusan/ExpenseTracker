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
        backgroundColor: MyColor.colorPageBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInputCard(),
                      const SizedBox(height: 16),
                      _buildConvertButton(),
                      const SizedBox(height: 24),
                      if (_incomeController.isConvert.isTrue) ...[
                        _buildResultCards(),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.paddingOf(context).top + 24, 20, 60),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.colorPrimaryGreen, MyColor.colorPrimaryGreenHover],
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income Tracker',
            style: TextStyle(
              color: MyColor.colorWhite,
              fontSize: FontSize.textSizeExtraLarge,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Track your daily earnings easily',
            style: TextStyle(
              color: Colors.white70,
              fontSize: FontSize.textSizeNormalReaderView,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _incomeController.incomeTextController.value,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: MyColor.colorTextBlack,
              fontSize: FontSize.textSizeExtraXLarge,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              labelText: 'Income Amount',
              labelStyle: const TextStyle(
                color: MyColor.colorTextHint,
                fontSize: FontSize.textSizeNormal,
              ),
              hintText: '0',
              hintStyle: const TextStyle(
                color: MyColor.colorNeutral300,
                fontSize: FontSize.textSizeExtraXLarge,
                fontWeight: FontWeight.w800,
              ),
              filled: true,
              fillColor: MyColor.colorPrimaryGreenTint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: MyColor.colorPrimaryGreen, width: 2),
              ),
              prefixIcon: const Icon(
                Icons.payments,
                color: MyColor.colorPrimary,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConvertButton() {
    return GestureDetector(
      onTap: () {
        _incomeController.isConvert(true);

        if (_incomeController.incomeTextController.value.text.isNotEmpty) {
          _incomeController.convertMoney();
        }
        print("Convert::${_incomeController.isConvert}");
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [MyColor.colorPrimary, Color(0xffFB7185)],
          ),
          boxShadow: [
            BoxShadow(
              color: MyColor.colorPrimary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, color: MyColor.colorWhite, size: 24),
            SizedBox(width: 8),
            Text(
              'Convert',
              style: TextStyle(
                color: MyColor.colorWhite,
                fontSize: FontSize.textSizeNormalReaderView,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCards() {
    return Row(
      children: [
        Expanded(
          child: _buildCard(
            icon: Icons.account_balance_wallet,
            iconColor: MyColor.colorPrimary,
            gradient: const [Color(0xffFFF1F2), Color(0xffFFE4E6)],
            title: "Income Money",
            value: _incomeController.incomeTextController.value.text,
            valueColor: MyColor.colorPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildCard(
            icon: Icons.calendar_month,
            iconColor: MyColor.colorTeal600,
            gradient: const [Color(0xffF0FDFA), Color(0xffCCFBF1)],
            title: "Average daily",
            value: _incomeController.payIncome.truncate().toString(),
            valueColor: MyColor.colorTeal600,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required List<Color> gradient,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: MyColor.colorTextBlack800,
              fontSize: FontSize.textSizeExtraSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: FontSize.textSizeExtraLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
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
