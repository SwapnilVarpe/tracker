import 'package:intl/intl.dart';

bool isNumeric(String source) {
  return double.tryParse(source) != null;
}

final _formatter = NumberFormat('##,##,##,###.##');
String getIndianNumFormat(double num) => _formatter.format(num);
