import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fast_csv/fast_csv.dart' as _fast_csv;
import 'package:tracker/constants.dart';
import 'package:tracker/db/db_helper.dart';

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
  List<Entry> entriesToBeAdded = [];
  List<String> messages = [];
  HashSet<Category> newCatTobeAdded = HashSet<Category>();

  @override
  Widget build(BuildContext context) {
    var catStateProvider = categoryStateProvider('');
    var categoryState = ref.watch(catStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Import')),
      body: isFileProcessed
          ? confirmImport(catStateProvider)
          : importButton(categoryState.allCategoryList),
    );
  }

  Center importButton(List<Category> allCategoryList) {
    return Center(
        child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

              if (result != null) {
                var entries = await processFile(result);
                processAndSetEntries(entries, allCategoryList);
              }
            },
            child: const Text('Import CSV')));
  }

  Future<List<Entry>> processFile(FilePickerResult result) async {
    File file = File(result.files.single.path ?? '');

    String csv = await file.readAsString();
    return parseEntries(csv);
  }

  List<Entry> parseEntries(String csv) {
    var rows = _fast_csv.parse(csv);
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

  Column confirmImport(
      StateNotifierProvider<CategoryNotifier, CategoryState> catStateProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Number of entries: ${entriesToBeAdded.length}',
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
                  int entryCount =
                      await DBHelper.insertManyEntry(entriesToBeAdded);
                  if (entryCount == entriesToBeAdded.length) {
                    msg = '$entryCount entries added';
                  } else {
                    msg = 'Error: $entryCount entries added';
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

  void processAndSetEntries(
      List<Entry> entries, List<Category> allCategoryList) {
    List<String> msg = [];
    HashSet<Category> newCategories = HashSet<Category>();
    List<Entry> newEntries = [];

    for (var entry in entries) {
      if (entry.title.isEmpty) {
        msg.add(
            'Error: Title is empty: ${entry.datetime} ${entry.amount}) ${entry.category}');
        continue;
      }
      if (entry.datetime.isEmpty || DateTime.tryParse(entry.datetime) == null) {
        msg.add('Error: Invalid date: ${entry.title}');
        continue;
      }
      if (entry.category.isEmpty) {
        msg.add('Error: Cat not found: ${entry.title}');
        continue;
      }
      var existingCat = allCategoryList.where((element) =>
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
    });
  }
}
