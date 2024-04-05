import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/db/db_helper.dart';

import 'package:tracker/modal/activity.dart';

final dayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final hourProvider = StateProvider((ref) {
  var day = ref.watch(dayProvider);

  List<DateTime> list = [];
  var now = day;
  var timeCounter = DateTime(now.year, now.month, now.day, 0, 0, 0);
  for (int hour = 0; hour <= 23; hour++) {
    list.add(timeCounter);
    timeCounter = timeCounter.add(const Duration(hours: 1));
  }
  return list;
});

class ActivityData {
  const ActivityData({required this.planned, required this.actual});

  final Map<int, List<Activity>> planned;
  final Map<int, List<Activity>> actual;
}

final dayActivityProvider = FutureProvider<ActivityData>((ref) async {
  var day = ref.watch(dayProvider);
  var planned = <int, List<Activity>>{};
  var actual = <int, List<Activity>>{};

  var list = await DBHelper.getActivitiesByDay(day);

  for (var activity in list) {
    if (activity.taskEntryType == TaskEntryType.planned) {
      var hour = activity.activityDate.hour;
      if (planned.containsKey(hour)) {
        planned[hour]?.add(activity);
      } else {
        planned[hour] = [activity];
      }
    } else {
      var hour = activity.activityDate.hour;
      if (actual.containsKey(hour)) {
        actual[hour]?.add(activity);
      } else {
        actual[hour] = [activity];
      }
    }
  }
  return ActivityData(planned: planned, actual: actual);
});
