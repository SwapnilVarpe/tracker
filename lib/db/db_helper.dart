import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/modal/category.dart';
import 'package:tracker/modal/entry.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 2;
  static const String _entryTable = "entry";
  static const String _categoryTable = 'category';
  static const String _activityTable = 'activity';

  static Future<void> initDB() async {
    if (_database != null) return;

    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'tracker.db'),
        version: _version,
        onCreate: _onCreateDB,
        onUpgrade: _onUpgradeDB,
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  static void _createActivitySchema(db) {
    db.execute(
      "CREATE TABLE $_activityTable("
      "id INTEGER PRIMARY KEY, "
      "uuid TEXT,"
      "title TEXT,"
      "activityDate TEXT,"
      "category TEXT,"
      "subCategory TEXT,"
      "taskEntryType TEXT,"
      "isGroupActivity INTEGER,"
      "duration INTEGER,"
      "difficulty INTEGER,"
      "satisfaction INTEGER,"
      "copyUuid TEXT"
      ")",
    );

    var activityList = [
      'Reading Book',
      'Morning Routine',
      'Exercise',
      'Yoga',
      'Learning',
      'Rest',
      'Meals',
      'Housework',
      'Coding',
    ];
    for (var act in activityList) {
      db.insert(
          _categoryTable,
          Category(
                  category: act,
                  categoryType: CategoryType.activity,
                  subCategory: '')
              .toMap());
    }
  }

  static FutureOr<void> _onUpgradeDB(db, oldVersion, newVersion) {
    if (oldVersion == 1) {
      _createActivitySchema(db);
    }
  }

  static FutureOr<void> _onCreateDB(db, version) {
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

    // Activity table
    _createActivitySchema(db);
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

  static Future<List<Category>> getAllCategories(bool isActivity) async {
    final List<Map<String, dynamic>> maps = await _database!.query(
        _categoryTable,
        where: isActivity ? 'categoryType = ? ' : 'categoryType <> ? ',
        whereArgs: [CategoryType.activity.asString()]);

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

  static Future<List<Entry>> getAllEntries() async {
    final maps = await _database!.query(_entryTable);

    return List.generate(maps.length, (index) {
      var entry = maps[index];
      return Entry.fromMap(entry);
    });
  }

  static Future<List<Entry>> getEntriesByRange(String start, String end) async {
    if (_database == null) {
      return [];
    }
    final List<Map<String, dynamic>> maps = await _database!.query(_entryTable,
        where: 'datetime >= ? AND datetime <= ?',
        whereArgs: [start, end],
        orderBy: 'datetime DESC, id DESC');

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

  // Activity functions
  static Future<int> insertActivity(Activity activity) async {
    return await _database!.insert(_activityTable, activity.toJson());
  }

  static Future<int> deleteActivity(int id) async {
    return await _database!
        .delete(_activityTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateActivity(Activity activity) async {
    return await _database!.update(_activityTable, activity.toJson(),
        where: 'id = ?', whereArgs: [activity.id]);
  }

  static Future<Activity?> getActivityById(String id) async {
    final List<Map<String, dynamic>> maps = await _database!
        .query(_activityTable, where: 'id = ?', whereArgs: [id]);

    if (maps.isEmpty) {
      return null;
    }

    return Activity.fromJson(maps[0]);
  }

  static Future<List<Activity>> getActivitiesByDay(DateTime day) async {
    var start = DateTime(day.year, day.month, day.day, 0);
    var end = DateTime(day.year, day.month, day.day, 23, 59, 59);

    final List<Map<String, dynamic>> maps = await _database!.query(
      _activityTable,
      where: 'activityDate >= ? AND activityDate <= ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );

    return List.generate(maps.length, (index) {
      var activity = maps[index];
      return Activity.fromJson(activity);
    });
  }

  static Future<List<Activity>> getAllActivities() async {
    final maps = await _database!.query(_activityTable);

    return List.generate(maps.length, (index) {
      var activity = maps[index];
      return Activity.fromJson(activity);
    });
  }
}
