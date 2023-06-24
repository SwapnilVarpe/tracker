import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracker/modal/entry.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _entryTable = "entry";

  static Future<void> initDB() async {
    if (_database != null) return;

    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'tracker.db'),
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_entryTable("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT, datetime TEXT, amount REAL,"
            "categoryType TEXT,"
            "category TEXT"
            ")",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertEntry(Entry entry) async {
    return await _database!.insert(_entryTable, entry.toMap());
  }

  static Future<List<Entry>> getEntriesByRange(String start, String end) async {
    if (_database == null) {
      return [];
    }
    final List<Map<String, dynamic>> maps = await _database!.query(_entryTable,
        where: 'datetime >= ? AND datetime <= ?', whereArgs: [start, end]);

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry(
          title: entry['title'],
          datetime: entry['datetime'],
          amount: entry['amount'],
          categoryType: entry['categoryType'],
          category: entry['category']);
    });
  }
}
