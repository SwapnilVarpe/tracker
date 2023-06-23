import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';

final catTypeProvider = StateProvider<CategoryType>((ref) {
  return CategoryType.income;
});
