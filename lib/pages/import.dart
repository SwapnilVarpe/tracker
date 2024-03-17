import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fast_csv/fast_csv.dart' as fast_csv;
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/activity.dart';

import 'package:tracker/modal/category.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/category_provider.dart';

class Import extends ConsumerStatefulWidget {
  const Import({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImportState();
}

class _ImportState extends ConsumerState<Import> {
  bool isFileProcessed = false;
  List<Category> entryCategories = [];
  List<Category> activityCategories = [];
  List<Entry> entriesToBeAdded = [];
  List<Activity> activitiesToBeAdded = [];
  List<String> messages = [];
  bool isActivity = false;
  HashSet<Category> newCatTobeAdded = HashSet<Category>();

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() async {
    entryCategories = await DBHelper.getAllCategories(false);
    activityCategories = await DBHelper.getAllCategories(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import')),
      body: isFileProcessed ? confirmImport() : importButton(),
    );
  }

  Center importButton() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['csv']);

                if (result != null) {
                  var entries = await parseEntries(result);
                  processAndSetEntries(entries);
                }
              },
              child: const Text('Import Entries CSV')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['csv']);

                if (result != null) {
                  var data = await parseActivities(result);
                  processAndSetActivities(data);
                }
              },
              child: const Text('Import Activities CSV')),
        ),
      ],
    ));
  }

  Future<List<Activity>> parseActivities(FilePickerResult result) async {
    File file = File(result.files.single.path ?? '');
    String csv = await file.readAsString();

    var rows = fast_csv.parse(csv);
    List<Activity> activities = [];
    // 'UUID,Date,Title,Category,Sub Category,Entry type,Is group Activity,Duration,Difficulty,Satisfaction,Copy UUID');
    rows.skip(1).forEach((row) {
      activities.add(Activity(
          uuid: row[0],
          activityDate: DateTime.parse(row[1]),
          title: row[2],
          category: row[3],
          subCategory: row[4],
          taskEntryType: TaskEntryTypeExt.fromString(row[5]),
          isGroupActivity: int.tryParse(row[6]) ?? 0,
          duration: double.tryParse(row[7]) ?? 0,
          difficulty: double.tryParse(row[8]) ?? 0,
          satisfaction: double.tryParse(row[9]) ?? 0,
          copyUuid: row[10]));
    });
    return activities;
  }

  Future<List<Entry>> parseEntries(FilePickerResult result) async {
    File file = File(result.files.single.path ?? '');
    String csv = await file.readAsString();

    var rows = fast_csv.parse(csv);
    List<Entry> entries = [];
    // Date,Title,Category Type,Category,Amount,SubCat
    rows.skip(1).forEach((row) {
      entries.add(Entry(
          datetime: row[0],
          title: row[1],
          amount: double.tryParse(row[2]) ?? 0,
          categoryType: CategoryTypeExt.fromString(row[3]),
          category: row[4],
          subCategory: row[5]));
    });
    return entries;
  }

  Column confirmImport() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Number of ${isActivity ? 'Activities' : 'Entries'}: ${isActivity ? activitiesToBeAdded.length : entriesToBeAdded.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'New categories & sub categories to be added',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: ListView(
          children: newCatTobeAdded
              .map((e) => ListTile(
                    title: Text(
                        'Cat: ${e.category} ${e.subCategory.isNotEmpty ? 'SubCat: ${e.subCategory}' : ''}'),
                  ))
              .toList(),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
              onPressed: () async {
                var newCatList = newCatTobeAdded.toList();
                int num = await DBHelper.insertManyCategory(newCatList);
                String msg = '';
                if (num == newCatList.length) {
                  int insertCount = 0;
                  int dataCount = isActivity
                      ? activitiesToBeAdded.length
                      : entriesToBeAdded.length;

                  if (isActivity) {
                    insertCount =
                        await DBHelper.insertManyActivity(activitiesToBeAdded);
                  } else {
                    insertCount =
                        await DBHelper.insertManyEntry(entriesToBeAdded);
                  }
                  if (insertCount == dataCount) {
                    msg = '$insertCount entries added';
                  } else {
                    msg = 'Error: $insertCount entries added';
                  }
                } else {
                  msg = 'Error while adding categories';
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(msg)));
                }
                ref.invalidate(categoryStateProvider);
              },
              child: const Text('Insert into DB')),
        )
      ],
    );
  }

  void processAndSetActivities(List<Activity> entries) {
    List<String> msg = [];
    HashSet<Category> newCategories = HashSet<Category>();
    List<Activity> newEntries = [];

    for (var entry in entries) {
      if (entry.uuid.isEmpty) {
        msg.add('Error: UUID not found: ${entry.title} ${entry.category}');
        continue;
      }
      if (entry.category.isEmpty) {
        msg.add('Error: Cat not found: ${entry.title} ${entry.category}');
        continue;
      }
      var existingCat = activityCategories.where((element) =>
          element.categoryType == CategoryType.activity &&
          element.category == entry.category &&
          element.subCategory == entry.subCategory);
      if (existingCat.isEmpty) {
        newCategories.add(Category(
            category: entry.category,
            categoryType: CategoryType.activity,
            subCategory: entry.subCategory));
      }
      newEntries.add(entry);
    }

    setState(() {
      activitiesToBeAdded = newEntries;
      newCatTobeAdded = newCategories;
      messages = msg;
      isFileProcessed = true;
      isActivity = true;
    });
  }

  void processAndSetEntries(List<Entry> entries) {
    List<String> msg = [];
    HashSet<Category> newCategories = HashSet<Category>();
    List<Entry> newEntries = [];

    for (var entry in entries) {
      if (entry.datetime.isEmpty || DateTime.tryParse(entry.datetime) == null) {
        msg.add('Error: Invalid date: ${entry.title}');
        continue;
      }
      if (entry.category.isEmpty) {
        msg.add('Error: Cat not found: ${entry.title}');
        continue;
      }
      var existingCat = entryCategories.where((element) =>
          element.categoryType == entry.categoryType &&
          element.category == entry.category &&
          element.subCategory == entry.subCategory);
      if (existingCat.isEmpty) {
        newCategories.add(Category(
            category: entry.category,
            categoryType: entry.categoryType,
            subCategory: entry.subCategory));
      }
      newEntries.add(entry);
    }

    setState(() {
      entriesToBeAdded = newEntries;
      newCatTobeAdded = newCategories;
      messages = msg;
      isFileProcessed = true;
      isActivity = false;
    });
  }
}
