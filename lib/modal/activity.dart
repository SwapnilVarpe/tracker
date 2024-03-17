import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

enum TaskEntryType { planned, actual }

extension TaskEntryTypeExt on TaskEntryType {
  String asString() {
    if (this == TaskEntryType.actual) return 'Actual';
    if (this == TaskEntryType.planned) return 'Planned';
    return '';
  }

  static TaskEntryType fromString(String str) {
    if (str == 'Actual') return TaskEntryType.actual;
    if (str == 'Planned') return TaskEntryType.planned;
    return TaskEntryType.actual;
  }
}

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
      required String uuid,
      String? copyUuid}) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) =>
      _$ActivityFromJson(json);
}
