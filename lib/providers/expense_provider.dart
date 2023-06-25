import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker/modal/entry.dart';

import '../constants.dart';
import 'package:tracker/db/db_helper.dart';

final monthProvider = StateProvider<String>((ref) {
  var curMonth = DateTime.now().month;
  return months[curMonth - 1];
});

final entryListProvider = FutureProvider<List<Entry>>((ref) async {
  var curMonth = ref.watch(monthProvider);
  var monthIndex = months.indexOf(curMonth) + 1;
  var year = DateTime.now().year;

  var startOfMonth =
      DateFormat('yyyy-MM-dd').format(DateTime(year, monthIndex, 1));
  var endOfMonth =
      DateFormat('yyyy-MM-dd').format(DateTime(year, monthIndex + 1, 0));
  var list = await DBHelper.getEntriesByRange(startOfMonth, endOfMonth);

  return list;
});

final summaryProvider = Provider((ref) {
  var entryList = ref.watch(entryListProvider);

  Map<String, double> summary = {};

  return entryList.whenData((value) {
    for (var entry in value) {
      final catType = entry.categoryType.asString();
      summary[catType] = (summary[catType] ?? 0) + entry.amount;
    }
    return summary;
  });
});
