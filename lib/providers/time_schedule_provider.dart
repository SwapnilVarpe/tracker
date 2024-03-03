import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tracker/modal/activity.dart';

final dayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class ActivityData {
  const ActivityData({required this.planned, required this.actual});

  final Map<int, List<Activity>> planned;
  final Map<int, List<Activity>> actual;
}

final dayActivityProvider = FutureProvider<ActivityData>((ref) async {
  var day = ref.watch(dayProvider);
  var testMap = <int, List<Activity>>{};
  var testMap2 = <int, List<Activity>>{};

  var testA = Activity(
      title: "Text",
      category: '',
      subCategory: '',
      activityDate: DateTime.now(),
      taskEntryType: TaskEntryType.planned,
      isGroupActivity: false,
      duration: 10,
      difficulty: 1,
      satisfaction: 1);
  testMap[10] = [testA];
  testMap2[15] = [testA.copyWith(taskEntryType: TaskEntryType.actual)];
  return ActivityData(planned: testMap, actual: testMap2);
});
