import 'package:intl/intl.dart';

import 'constants.dart';

bool isNumeric(String source) {
  return double.tryParse(source) != null;
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
String getIndianNumFormat(double num) => _formatter.format(num);
