class Category {
  final String categoryType;
  final String category;
  final String subCategory;

  const Category(
      {required this.category,
      required this.categoryType,
      required this.subCategory});

  Map<String, String> toMap() {
    return {
      'categoryType': categoryType,
      'category': category,
      'subCategory': subCategory
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        category: map['category'] ?? '',
        categoryType: map['categoryType'] ?? '',
        subCategory: map['subCategory'] ?? '');
  }
}
