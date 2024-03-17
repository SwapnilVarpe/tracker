import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/providers/modal/money_stat.dart';
import 'package:tracker/util.dart';

class MoneyStateNotifier extends StateNotifier<MoneyStat> {
  MoneyStateNotifier(super.state) {
    _updateEntries();
    _scrollToMonth();
  }

  _updateEntries() async {
    String start = state.startDate;
    String end = state.endDate;

    if (state.filterBy == FilterBy.month) {
      var range = getMonthRange(state.month);
      start = range.start;
      end = range.end;
    }
    var entries =
        await DBHelper.getGroupbyCatEntries(start, end, state.categoryType);
    state = state.copyWith(entries: entries);
  }

  set filterBy(FilterBy filter) {
    var range = getMonthRange(state.month);
    state = state.copyWith(
        filterBy: filter, startDate: range.start, endDate: range.end);
    _updateEntries();
  }

  set month(String month) {
    var range = getMonthRange(month);
    state = state.copyWith(
        month: month, startDate: range.start, endDate: range.end);
    _updateEntries();
  }

  set startDate(String date) {
    state = state.copyWith(startDate: date);
    _updateEntries();
  }

  set endDate(String date) {
    state = state.copyWith(endDate: date);
    _updateEntries();
  }

  set categoryType(CategoryType type) {
    state = state.copyWith(categoryType: type, category: '');
    _updateEntries();
  }

  set category(String cat) {
    state = state.copyWith(category: cat);
  }

  _scrollToMonth() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (state.itemScrollController.isAttached) {
          var curMonth = DateTime.now().month;
          if (curMonth - 3 > 0) {
            state.itemScrollController.scrollTo(
                index: curMonth - 3,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }
      },
    );
  }
}

final moneyStateProvider =
    StateNotifierProvider<MoneyStateNotifier, MoneyStat>((ref) {
  var curMonth = DateTime.now().month;
  var range = getMonthRange(months[curMonth - 1]);
  return MoneyStateNotifier(MoneyStat(
      filterBy: FilterBy.month,
      month: months[curMonth - 1],
      startDate: range.start,
      endDate: range.end,
      categoryType: CategoryType.expense,
      category: '',
      itemScrollController: ItemScrollController(),
      entries: []));
});
