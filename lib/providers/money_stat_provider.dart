import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/modal/money_stat.dart';
import 'package:tracker/util.dart';

class MoneyStateNotifier extends StateNotifier<MoneyStat> {
  MoneyStateNotifier(MoneyStat state) : super(state) {
    _init();
  }

  _init() async {
    var catList = await DBHelper.getAllCategories();
    var range = getMonthRange(state.month);
    var entries = await DBHelper.getEntriesByRange(range.start, range.end);
    state = state.copyWith(categories: catList, entries: entries);
  }

  set month(String month) {
    state = state.copyWith(month: month);
    _init();
  }

  set categoryType(CategoryType type) {
    state = state.copyWith(categoryType: type, category: '', subCategory: '');
  }

  set category(String cat) {
    state = state.copyWith(category: cat, subCategory: '');
  }

  set subCategory(String subCat) {
    state = state.copyWith(subCategory: subCat);
  }

  List<String> getCategories() {
    return state.categories
        .where((element) =>
            element.categoryType == state.categoryType &&
            element.subCategory.isEmpty)
        .map((e) => e.category)
        .toList();
  }

  List<String> getSubCategories() {
    if (state.category.isEmpty) {
      return [];
    }
    return state.categories
        .where((element) =>
            element.categoryType == state.categoryType &&
            element.category == state.category &&
            element.subCategory.isNotEmpty)
        .map((e) => e.subCategory)
        .toList();
  }

  List<Entry> getEntries() {
    return state.entries
        .where((element) =>
            element.categoryType == state.categoryType &&
            (state.category.isEmpty || element.category == state.category) &&
            (state.subCategory.isEmpty ||
                element.subCategory == state.subCategory))
        .toList();
  }
}

final moneyStateProvider =
    StateNotifierProvider<MoneyStateNotifier, MoneyStat>((ref) {
  var curMonth = DateTime.now().month;
  return MoneyStateNotifier(MoneyStat(
      month: months[curMonth - 1],
      categoryType: CategoryType.expense,
      category: '',
      subCategory: '',
      total: 0,
      categories: [],
      entries: []));
});
