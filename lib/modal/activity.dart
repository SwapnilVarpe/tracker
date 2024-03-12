import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

enum TaskEntryType { planned, actual }

@freezed
class Activity with _$Activity {
  const factory Activity(
      {int? id,
      required String title,
      required String category,
      required String subCategory,
      required DateTime activityDate,
      required TaskEntryType taskEntryType,
      required int isGroupActivity,
      required double duration,
      required double difficulty,
      required double satisfaction,
      int? copyId}) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) =>
      _$ActivityFromJson(json);
}
