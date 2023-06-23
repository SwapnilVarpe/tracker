import 'dart:convert';
import 'dart:ffi';

class Entry {
  final int? id;
  final String title;
  final int datetime;
  final Float amount;
  final String categoryType;
  final String category;

  const Entry(
      {this.id,
      required this.title,
      required this.datetime,
      required this.amount,
      required this.categoryType,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'datetime': datetime,
      'amount': amount,
      'categoryType': categoryType,
      'category': category
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'],
        title: map['title'] ?? "",
        datetime: map['datetime'] ?? 0,
        amount: map['amount'] ?? 0,
        categoryType: map['categoryType'] ?? "",
        category: map['category'] ?? "");
  }

  String toJSON() => json.encode(toMap());

  factory Entry.fromJSON(String source) =>
      Entry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    var date = DateTime.fromMillisecondsSinceEpoch(datetime);
    return 'Entry(${date.toIso8601String()}, $id, $title, $amount, $categoryType, $category)';
  }
}
