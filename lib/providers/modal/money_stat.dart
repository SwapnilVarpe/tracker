import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/modal/entry.dart';

part 'money_stat.freezed.dart';

enum FilterBy { month, dateRage }

@freezed
class MoneyStat with _$MoneyStat {
  const factory MoneyStat(
      {required FilterBy filterBy,
      required String month,
      required String startDate,
      required String endDate,
      required CategoryType categoryType,
      required String category,
      required ItemScrollController itemScrollController,
      required List<Entry> entries}) = _MoneyStat;
}
