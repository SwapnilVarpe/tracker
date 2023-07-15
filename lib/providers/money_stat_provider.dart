import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/providers/modal/money_stat.dart';
import 'package:tracker/util.dart';

class MoneyStateNotifier extends StateNotifier<MoneyStat> {
  MoneyStateNotifier(MoneyStat state) : super(state) {
    _updateEntries();
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
    state = state.copyWith(categoryType: type, category: '', subCategory: '');
    _updateEntries();
  }

  set category(String cat) {
    state = state.copyWith(category: cat, subCategory: '');
  }

  set subCategory(String subCat) {
    state = state.copyWith(subCategory: subCat);
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
      subCategory: '',
      total: 0,
      categories: [],
      entries: []));
});
