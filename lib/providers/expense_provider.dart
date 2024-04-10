import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/util.dart';

import '../constants.dart';
import 'package:tracker/db/db_helper.dart';

final monthProvider = StateProvider<int>((ref) {
  var curMonth = DateTime.now().month;
  return curMonth - 1;
});

final entryListProvider = FutureProvider<List<Entry>>((ref) async {
  var curMonth = ref.watch(monthProvider);
  var range = getMonthRange(months[curMonth]);
  var list = await DBHelper.getEntriesByRange(range);

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
