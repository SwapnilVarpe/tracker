import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/providers/modal/time_stat.dart';

final dateRangeProvider = StateProvider<DateTimeRange>((ref) {
  var now = DateTime.now();
  return DateTimeRange(start: now, end: now);
});

final statTypeProvider = StateProvider<StatsType>((ref) {
  return StatsType.timeSpent;
});

final statsProvider = FutureProvider.autoDispose<List<TimeStat>>((ref) async {
  var range = ref.watch(dateRangeProvider);
  var statsType = ref.watch(statTypeProvider);

  // ToDo
  if (statsType != StatsType.timeSpent) return [];

  var activityList = await DBHelper.getActivitiesByDayRange(range);

  Map<String, TimeStat> map = HashMap();
  for (var activity in activityList) {
    if (activity.taskEntryType == TaskEntryType.planned) continue;

    if (map.containsKey(activity.category)) {
      var ts = map[activity.category];
      ts?.duration += activity.duration;

      // Adding to subcat
      if (activity.subCategory.isNotEmpty) {
        var subCatIndex = ts?.subCategory
            .indexWhere((element) => element.category == activity.subCategory);

        if (subCatIndex != null) {
          if (subCatIndex != -1) {
            ts?.subCategory[subCatIndex].duration += activity.duration;
          } else {
            ts?.subCategory.add(TimeStat(
                category: activity.subCategory, duration: activity.duration));
          }
        }
      }
    } else {
      var timeStat =
          TimeStat(category: activity.category, duration: activity.duration);
      if (activity.subCategory.isNotEmpty) {
        timeStat.subCategory.add(TimeStat(
            category: activity.subCategory, duration: activity.duration));
      }
      map[activity.category] = timeStat;
    }
  }
  var list = map.values.toList(growable: false);
  list.sort((ts1, ts2) {
    return ts2.duration.compareTo(ts1.duration);
  });
  return list;
});
