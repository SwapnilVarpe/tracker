import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';

final catTypeProvider = StateProvider<CategoryType>((ref) {
  return CategoryType.expense;
});

final currentCatProvider = StateProvider<String>((ref) {
  var category = ref.watch(categoryProvider);
  return category.isNotEmpty ? category[0] : 'Not found';
});

final categoryProvider = StateProvider<List<String>>((ref) {
  var catType = ref.watch(catTypeProvider);

  switch (catType) {
    case CategoryType.expense:
      return ['Bill', 'Shopping', 'Health'];
    case CategoryType.income:
      return ['Salary', 'Interest'];
    case CategoryType.investment:
      return ['Stock', 'T-Bill'];
  }
});
