import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/category.dart';

// Common providers between new_entry and new_category pages.

final catTypeProvider = StateProvider<CategoryType>((ref) {
  return CategoryType.expense;
});

final categoryProvider = FutureProvider<List<Category>>((ref) async {
  var catType = ref.watch(catTypeProvider);

  var catList = await DBHelper.getAllCategories();

  return catList.where((element) => element.categoryType == catType).toList();
});

final selectedCatProvider = StateProvider<String>((ref) {
  var category = ref.watch(categoryProvider);
  var list = category.asData?.value;

  return list != null && list.isNotEmpty ? list[0].category : '';
});

final subCategoryProvider = Provider<List<String>>((ref) {
  var catType = ref.watch(catTypeProvider);
  var category = ref.watch(selectedCatProvider);
  var catList = ref.watch(categoryProvider);

  return catList.when(
    data: (data) {
      return data
          .where((element) =>
              element.categoryType == catType &&
              element.category == category &&
              element.subCategory.isNotEmpty)
          .map((e) => e.subCategory)
          .toList();
    },
    error: (error, stackTrace) => [],
    loading: () => [],
  );
});

final selectedSubCatProvider = StateProvider<String>((ref) {
  // 'None' is added so that sub cat can be unselected.
  return 'None';
});
