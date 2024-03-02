import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/activity.dart';

final dayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final dayActivityProvider = FutureProvider<List<Activity>>((ref) async {
  var day = ref.watch(dayProvider);
  return List.empty();
});
