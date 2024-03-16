import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/modal/entry.dart';

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
    case CategoryType.activity:
      return Colors.black;
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
    case CategoryType.activity:
      return Icons.man;
  }
}

class DateRange {
  final String start;
  final String end;
  DateRange(this.start, this.end);
}

const dateFormat = 'yyyy-MM-dd';
DateRange getMonthRange(String month) {
  var monthIndex = months.indexOf(month) + 1;
  assert(monthIndex > 0 && monthIndex < 12);
  var year = DateTime.now().year;

  var startOfMonth =
      DateFormat(dateFormat).format(DateTime(year, monthIndex, 1));
  var endOfMonth =
      DateFormat(dateFormat).format(DateTime(year, monthIndex + 1, 0));

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

String convertToCSV(List<Entry> enties) {
  StringBuffer buffer = StringBuffer();
  buffer.writeln('Date,Title,Amount,Category Type,Category,Sub Category');

  for (var entry in enties) {
    buffer.writeln(
        '${entry.datetime},"${entry.title}",${entry.amount},${entry.categoryType.asString()},${entry.category},${entry.subCategory}');
  }

  return buffer.toString();
}

String convertActivityToCSV(List<Activity> activities) {
  StringBuffer buffer = StringBuffer();
  buffer.writeln(
      'Id,Date,Title,Category,Sub Category,Entry type,Is group Activity,Duration,Difficulty,Satisfaction,Copy Id');

  for (var act in activities) {
    buffer.writeln(
        '${act.id},${act.activityDate.toIso8601String()},"${act.title}",${act.category},${act.subCategory},${act.taskEntryType.asString()},${act.isGroupActivity},${act.duration},${act.difficulty},${act.satisfaction},${act.copyId}');
  }

  return buffer.toString();
}

void exportCSV(String str, String fileName) async {
  final dir = await getTemporaryDirectory();
  final path = '${dir.path}/$fileName.csv';

  File file = File(path);
  await file.writeAsString(str);
  Share.shareXFiles([XFile(path, mimeType: 'text/csv')],
      subject: '$fileName.csv');
}
