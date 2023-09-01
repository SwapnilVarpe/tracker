import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_time_entry.freezed.dart';

@freezed
class NewTimeModel with _$NewTimeModel {
  const factory NewTimeModel(
      {required int hour,
      required String title,
      required String category,
      required String subCategory,
      required DateTime start,
      required DateTime end,
      required bool isFutureEntry,
      required bool isNotify,
      required bool isAllDay}) = _NewTimeModel;
}
