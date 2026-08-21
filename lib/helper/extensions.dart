import 'package:intl/intl.dart';

extension FormatAmountExtension on num {
  String formatAmount() {
    return '${NumberFormat('#,###').format(round())} Ks';
  }
}
