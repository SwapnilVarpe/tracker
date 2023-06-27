import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/category.dart';

final catTypeProvider = StateProvider<CategoryType>((ref) {
  return CategoryType.expense;
});

final currentCatProvider = StateProvider<String>((ref) {
  var category = ref.watch(categoryProvider);
  var list = category.asData?.value;

  return list != null && list.isNotEmpty ? list[0].category : '';
});

final categoryProvider = FutureProvider<List<Category>>((ref) async {
  var catType = ref.watch(catTypeProvider);

  var catList = await DBHelper.getAllCategories();

  return catList.where((element) => element.categoryType == catType).toList();
});
