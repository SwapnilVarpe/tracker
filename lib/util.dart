import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

bool isNumeric(String source) {
  return double.tryParse(source) != null;
}

Color getAmountColor(CategoryType categoryType) {
  switch (categoryType) {
    case CategoryType.expense:
      return Colors.red;
    case CategoryType.income:
      return Colors.green;
    case CategoryType.investment:
      return Colors.orange;
  }
}

IconData getAmountIcon(CategoryType categoryType) {
  switch (categoryType) {
    case CategoryType.expense:
      return Icons.payments;
    case CategoryType.income:
      return Icons.attach_money;
    case CategoryType.investment:
      return Icons.trending_up;
  }
}

class DateRange {
  final String start;
  final String end;
  DateRange(this.start, this.end);
}

DateRange getMonthRange(String month) {
  var monthIndex = months.indexOf(month) + 1;
  assert(monthIndex > 0 && monthIndex < 12);
  var year = DateTime.now().year;

  var startOfMonth =
      DateFormat('yyyy-MM-dd').format(DateTime(year, monthIndex, 1));
  var endOfMonth =
      DateFormat('yyyy-MM-dd').format(DateTime(year, monthIndex + 1, 0));

  return DateRange(startOfMonth, endOfMonth);
}

final _formatter = NumberFormat('##,##,##,###.##');
String formatNum(double num) => _formatter.format(num);

final _decimalFormatter = NumberFormat.decimalPatternDigits(decimalDigits: 2);
String formatDecimal2D(double num) => _decimalFormatter.format(num);

String formatDateDdMmm(String? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('dd MMM').format(DateTime.parse(date));
}
