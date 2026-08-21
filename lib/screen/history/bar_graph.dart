import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:expense_tracker/model/individual_bar_model.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> weeklySummary;
  const MyBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    if (weeklySummary.isEmpty) return const SizedBox.shrink();

    final maxValue = weeklySummary.reduce((a, b) => a > b ? a : b);
    final maxY = (maxValue * 1.3).clamp(100.0, 1000.0);

    final barData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thurAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    )..initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (_) => const FlLine(
            color: MyColor.colorNeutral100,
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  '${value.round()}',
                  style: const TextStyle(
                    color: MyColor.colorTextHint,
                    fontSize: FontSize.textSizeSmall,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: barData.barData
            .map((e) => BarChartGroupData(x: e.x, barRods: [
                  BarChartRodData(
                    toY: e.y,
                    width: 16,
                    borderRadius: BorderRadius.circular(6),
                    gradient: e.y == maxValue
                        ? const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xff128A65), Color(0xff2BD9A4)],
                          )
                        : const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xff18A87B), Color(0xff7CE0BC)],
                          ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: MyColor.colorGreyLight,
                    ),
                  ),
                ]))
            .toList(),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => MyColor.colorDarkBase,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = weeklySummary[group.x];
              return BarTooltipItem(
                '${value.toStringAsFixed(0)} Ks',
                const TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.textSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: MyColor.colorTextHint,
      fontWeight: FontWeight.w500,
      fontSize: FontSize.textSizeSmall,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('T', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('');
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
