import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/modal/category.dart';
import 'package:tracker/modal/entry.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _entryTable = "entry";
  static const String _categoryTable = 'category';

  static Future<void> initDB() async {
    if (_database != null) return;

    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'tracker.db'),
        version: _version,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE $_entryTable("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT, datetime TEXT, amount REAL,"
            "categoryType TEXT,"
            "subCategory TEXT,"
            "category TEXT"
            ")",
          );
          db.execute("CREATE TABLE $_categoryTable("
              "categoryType TEXT"
              "category TEXT"
              "subCategory TEXT");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertEntry(Entry entry) async {
    return await _database!.insert(_entryTable, entry.toMap());
  }

  static Future<int> insertCategory(Category category) async {
    return await _database!.insert(_categoryTable, category.toMap());
  }

  static Future<List<Category>> getAllCategories() async {
    final List<Map<String, dynamic>> maps =
        await _database!.query(_categoryTable);

    return List.generate(maps.length, (index) {
      return Category.fromMap(maps[index]);
    });
  }

  static Future<List<Entry>> getEntriesByRange(String start, String end) async {
    if (_database == null) {
      return [];
    }
    final List<Map<String, dynamic>> maps = await _database!.query(_entryTable,
        where: 'datetime >= ? AND datetime <= ?', whereArgs: [start, end]);

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }
}
