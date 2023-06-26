import 'dart:convert';

import '../constants.dart';

class Entry {
  final int? id;
  final String title;
  final String datetime;
  final double amount;
  final CategoryType categoryType;
  final String category;
  final String subCategory;

  const Entry(
      {this.id,
      required this.title,
      required this.datetime,
      required this.amount,
      required this.categoryType,
      required this.category,
      required this.subCategory});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'datetime': datetime,
      'amount': amount,
      'categoryType': categoryType.asString(),
      'category': category,
      'subCategory': subCategory
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'],
        title: map['title'] ?? '',
        datetime: map['datetime'] ?? 0,
        amount: map['amount'] ?? 0,
        categoryType: CategoryTypeExt.fromString(map['categoryType'] ?? ''),
        subCategory: map['subCategory'] ?? '',
        category: map['category'] ?? '');
  }

  String toJSON() => json.encode(toMap());

  factory Entry.fromJSON(String source) =>
      Entry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Entry($datetime, $id, $title, $amount, $categoryType, $category, $subCategory)';
  }
}
