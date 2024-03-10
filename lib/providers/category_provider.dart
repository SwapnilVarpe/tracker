import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker/constants.dart';

import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/category.dart' as cat;
import 'package:tracker/modal/entry.dart';
import 'package:tracker/util.dart';

@immutable
class TextControllers {
  final TextEditingController title;
  final TextEditingController amount;
  final TextEditingController date;

  const TextControllers(this.title, this.amount, this.date);
  factory TextControllers.init() {
    return TextControllers(
        TextEditingController(),
        TextEditingController(),
        TextEditingController(
            text: DateFormat(dateFormat).format(DateTime.now())));
  }

  void dispose() {
    amount.dispose();
    date.dispose();
    title.dispose();
  }
}

@immutable
class CategoryState {
  final bool isLoading;
  final TextControllers controllers;
  final CategoryType categoryType;
  final String selectedCategory;
  final String selectedSubCat;
  final List<cat.Category> allCategoryList;

  const CategoryState(
      {required this.isLoading,
      required this.controllers,
      required this.categoryType,
      required this.selectedCategory,
      required this.selectedSubCat,
      required this.allCategoryList});

  factory CategoryState.loading() {
    return CategoryState(
        isLoading: true,
        controllers: TextControllers.init(),
        categoryType: CategoryType.expense,
        selectedCategory: '',
        selectedSubCat: '',
        allCategoryList: const []);
  }

  CategoryState copyWith(
      {bool? isLoading,
      CategoryType? categoryType,
      String? selectedCategory,
      String? selectedSubCat,
      List<cat.Category>? categoryList}) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      controllers: controllers,
      categoryType: categoryType ?? this.categoryType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubCat: selectedSubCat ?? this.selectedSubCat,
      allCategoryList: categoryList ?? allCategoryList,
    );
  }

  List<cat.Category> categoryList() {
    return allCategoryList
        .where((element) =>
            element.categoryType == categoryType && element.subCategory.isEmpty)
        .toList()
      ..sort((a, b) => a.category.compareTo(b.category));
  }

  List<String> subCategoryList() {
    return allCategoryList
        .where((element) =>
            element.categoryType == categoryType &&
            element.category == selectedCategory &&
            element.subCategory.isNotEmpty)
        .map((e) => e.subCategory)
        .toList()
      ..sort();
  }
}

class CategoryNotifier extends StateNotifier<CategoryState> {
  final String entryId;
  final bool isActivity;
  CategoryNotifier({required this.entryId, required this.isActivity})
      : super(CategoryState.loading()) {
    _init();
  }

  Future<void> _init() async {
    var categoryList = await DBHelper.getAllCategories(isActivity);
    Entry? entry;

    if (entryId.isNotEmpty) {
      entry = await DBHelper.getEntryById(entryId);
    }

    // Update state, if entry exist then use it otherwise set default values.
    var catType = !isActivity
        ? entry?.categoryType ?? CategoryType.expense
        : CategoryType.activity;

    if (entry != null) {
      state.controllers.amount.text = entry.amount.toString();
      state.controllers.date.text = entry.datetime;
      state.controllers.title.text = entry.title;
    }

    state = state.copyWith(
        isLoading: false,
        categoryType: catType,
        categoryList: categoryList,
        selectedCategory: entry?.category ??
            categoryList
                .firstWhere((element) => element.categoryType == catType)
                .category,
        selectedSubCat: entry?.subCategory ?? '');
  }

  set categoryType(CategoryType catType) {
    var category = state.allCategoryList
        .firstWhere((element) => element.categoryType == catType);
    state = state.copyWith(
        categoryType: catType,
        selectedCategory: category.category,
        selectedSubCat: '');
  }

  set selectedCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  set selectedSubCat(String subCat) {
    state = state.copyWith(selectedSubCat: subCat);
  }

  void reload() async {
    var categoryList = await DBHelper.getAllCategories(isActivity);
    state = state.copyWith(categoryList: categoryList);
  }

  @override
  void dispose() {
    state.controllers.dispose();
    super.dispose();
  }
}

typedef CatProviderArg = ({String id, bool isActivity});

final categoryStateProvider = StateNotifierProvider.family<CategoryNotifier,
    CategoryState, CatProviderArg>((ref, arg) {
  return CategoryNotifier(entryId: arg.id, isActivity: arg.isActivity);
});
