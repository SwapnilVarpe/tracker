import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';

final monthProvider = StateProvider<String>((ref) {
  var curMonth = DateTime.now().month;
  return months[curMonth - 1];
});
