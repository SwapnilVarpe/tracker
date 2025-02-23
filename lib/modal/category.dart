import 'package:tracker/constants.dart';

class Category {
  final CategoryType categoryType;
  final String category;
  final String subCategory;

  const Category(
      {required this.category,
      required this.categoryType,
      required this.subCategory});

  Map<String, String> toMap() {
    return {
      'categoryType': categoryType.asString(),
      'category': category,
      'subCategory': subCategory
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        category: map['category'] ?? '',
        categoryType: CategoryTypeExt.fromString(map['categoryType']),
        subCategory: map['subCategory'] ?? '');
  }

  @override
  operator ==(other) =>
      other is Category &&
      categoryType == other.categoryType &&
      category == other.category &&
      subCategory == other.subCategory;

  @override
  int get hashCode => Object.hash(categoryType, category, subCategory);
}
