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
            "id INTEGER PRIMARY KEY, "
            "title TEXT, datetime TEXT, amount REAL,"
            "categoryType TEXT,"
            "subCategory TEXT,"
            "category TEXT"
            ")",
          );
          db.execute("CREATE TABLE $_categoryTable("
              "categoryType TEXT,"
              "category TEXT,"
              "subCategory TEXT"
              ")");
          // Adding basic categories
          var expList = [
            'Bill',
            'Health',
            'Grocery',
            'Shopping',
            'Food',
            'Petrol',
            'Medicine',
            'Book',
            'Car',
          ];
          for (var exp in expList) {
            db.insert(
                _categoryTable,
                Category(
                        category: exp,
                        categoryType: CategoryType.expense,
                        subCategory: '')
                    .toMap());
          }

          var incomeList = ['Salary', 'Interest', 'Dividend'];
          for (var income in incomeList) {
            db.insert(
                _categoryTable,
                Category(
                        category: income,
                        categoryType: CategoryType.income,
                        subCategory: '')
                    .toMap());
          }

          var investList = [
            'Mutual Fund',
            'Fixed Deposit',
            'Stocks',
            'T-Bill',
            'PPF'
          ];
          for (var invest in investList) {
            db.insert(
                _categoryTable,
                Category(
                        category: invest,
                        categoryType: CategoryType.investment,
                        subCategory: '')
                    .toMap());
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertEntry(Entry entry) async {
    return await _database!.insert(_entryTable, entry.toMap());
  }

  static Future<int> insertManyEntry(List<Entry> list) async {
    int total = 0;
    for (var entry in list) {
      int num = await insertEntry(entry);
      if (num > 0) {
        total++;
      }
    }
    return total;
  }

  static Future<int> insertCategory(Category category) async {
    return await _database!.insert(_categoryTable, category.toMap());
  }

  static Future<int> insertManyCategory(List<Category> list) async {
    int total = 0;
    for (var cat in list) {
      int num = await insertCategory(cat);
      if (num > 0) {
        total++;
      }
    }
    return total;
  }

  static Future<int> updateEntry(Entry entry) async {
    return await _database!.update(_entryTable, entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  static Future<List<Category>> getAllCategories() async {
    final List<Map<String, dynamic>> maps =
        await _database!.query(_categoryTable);

    return List.generate(maps.length, (index) {
      return Category.fromMap(maps[index]);
    });
  }

  static Future<Entry?> getEntryById(String id) async {
    final List<Map<String, dynamic>> maps =
        await _database!.query(_entryTable, where: 'id = ?', whereArgs: [id]);

    if (maps.isEmpty) {
      return null;
    }

    return Entry.fromMap(maps[0]);
  }

  static Future<List<Entry>> getEntriesByRange(String start, String end) async {
    if (_database == null) {
      return [];
    }
    final List<Map<String, dynamic>> maps = await _database!.query(_entryTable,
        where: 'datetime >= ? AND datetime <= ?',
        whereArgs: [start, end],
        orderBy: 'datetime DESC');

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }

  static Future<List<Entry>> getGroupbyCatEntries(
      String start, String end, CategoryType categoryType) async {
    final maps = await _database!.query(_entryTable,
        columns: ['sum(amount) as amount', 'category'],
        where: 'datetime >= ? AND datetime <= ? AND categoryType = ?',
        whereArgs: [start, end, categoryType.asString()],
        groupBy: 'category',
        orderBy: 'amount DESC');

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }

  static Future<List<Entry>> getGroupbySubCatEntries(String start, String end,
      CategoryType categoryType, String category) async {
    final maps = await _database!.query(_entryTable,
        columns: ['sum(amount) as amount', 'subCategory'],
        where:
            'datetime >= ? AND datetime <= ? AND categoryType = ? AND category = ?',
        whereArgs: [start, end, categoryType.asString(), category],
        groupBy: 'subCategory',
        orderBy: 'amount DESC');

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }

  static Future<List<Entry>> getSubCatEntries(String start, String end,
      CategoryType categoryType, String category) async {
    final maps = await _database!.query(_entryTable,
        where:
            'datetime >= ? AND datetime <= ? AND categoryType = ? AND category = ?',
        whereArgs: [start, end, categoryType.asString(), category],
        orderBy: 'datetime DESC');

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }

  static Future<int> deleteEntry(int id) async {
    return await _database!
        .delete(_entryTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteCategory(
      CategoryType categoryType, String category) async {
    var entries = await _database!.query(_entryTable,
        where: 'categoryType = ? AND category = ?',
        whereArgs: [categoryType.asString(), category]);

    if (entries.isEmpty) {
      return await _database!.delete(_categoryTable,
          where: 'categoryType = ? AND category = ?',
          whereArgs: [categoryType.asString(), category]);
    } else {
      return 0;
    }
  }

  static Future<int> deleteSubCategory(
      CategoryType catType, String category, String subCategory) async {
    var entries = await _database!.query(_entryTable,
        where: 'categoryType = ? AND subCategory = ? AND category = ?',
        whereArgs: [catType.asString(), subCategory, category]);

    if (entries.isEmpty) {
      return await _database!.delete(_categoryTable,
          where: 'categoryType = ? AND category = ? AND subCategory = ?',
          whereArgs: [catType.asString(), category, subCategory]);
    } else {
      return 0;
    }
  }
}
