import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/modal/category_entry_detail.dart';

class SubCatListItem {
  final bool isHeader;
  final bool isGroupby;
  final Entry? entry;
  final String header;
  const SubCatListItem(this.isHeader, this.entry, this.header, this.isGroupby);
}

final categoryEntryDetailsProvider = FutureProvider.autoDispose
    .family<List<SubCatListItem>, CategoryEntryDetail>((ref, arg) async {
  final subCatGroupby = await DBHelper.getGroupbySubCatEntries(
      arg.start, arg.end, arg.categoryType, arg.category);
  final subCatList = await DBHelper.getSubCatEntries(
      arg.start, arg.end, arg.categoryType, arg.category);

  List<SubCatListItem> list = [];
  // If group by is not present then only list.
  if (subCatGroupby.length == 1 && subCatGroupby[0].subCategory.isEmpty) {
    list.add(const SubCatListItem(true, null, 'List of entries', false));
    for (var element in subCatList) {
      list.add(SubCatListItem(false, element, '', false));
    }
    return list;
  }

  list.add(const SubCatListItem(
      true, null, 'Entries grouped by sub category', false));
  for (var element in subCatGroupby) {
    list.add(SubCatListItem(false, element, '', true));
  }

  list.add(const SubCatListItem(true, null, 'List of entries', false));
  for (var element in subCatList) {
    list.add(SubCatListItem(false, element, '', false));
  }

  return list;
});
