import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/modal/entry.dart';

part 'money_stat.freezed.dart';

enum FilterBy { month, dateRage }

@freezed
class MoneyStat with _$MoneyStat {
  const factory MoneyStat(
      {required FilterBy filterBy,
      required String month,
      required DateTimeRange dateRange,
      required CategoryType categoryType,
      required String category,
      required int initialScrollIndex,
      required List<Entry> entries}) = _MoneyStat;
}
