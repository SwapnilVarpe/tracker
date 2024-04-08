import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/providers/modal/money_stat.dart';
import 'package:tracker/util.dart';

class MoneyStateNotifier extends StateNotifier<MoneyStat> {
  MoneyStateNotifier(super.state) {
    _updateEntries();
  }

  _updateEntries() async {
    var curRange = state.dateRange;
    if (state.filterBy == FilterBy.month) {
      curRange = getMonthRange(state.month);
    }
    var entries =
        await DBHelper.getGroupbyCatEntries(curRange, state.categoryType);
    state = state.copyWith(entries: entries);
  }

  set filterBy(FilterBy filter) {
    var range = getMonthRange(state.month);
    state = state.copyWith(filterBy: filter, dateRange: range);
    _updateEntries();
  }

  set month(String month) {
    var range = getMonthRange(month);
    state = state.copyWith(month: month, dateRange: range);
    _updateEntries();
  }

  set dateRage(DateTimeRange range) {
    state = state.copyWith(dateRange: range);
    _updateEntries();
  }

  set categoryType(CategoryType type) {
    state = state.copyWith(categoryType: type, category: '');
    _updateEntries();
  }

  set category(String cat) {
    state = state.copyWith(category: cat);
  }
}

final moneyStateProvider =
    StateNotifierProvider<MoneyStateNotifier, MoneyStat>((ref) {
  var curMonth = DateTime.now().month;
  var range = getMonthRange(months[curMonth - 1]);
  var initMonthIndex = 0;
  if (curMonth - 3 > 0) {
    initMonthIndex = curMonth - 1;
  }

  return MoneyStateNotifier(MoneyStat(
      filterBy: FilterBy.month,
      month: months[curMonth - 1],
      dateRange: range,
      categoryType: CategoryType.expense,
      category: '',
      initialScrollIndex: initMonthIndex,
      entries: []));
});
