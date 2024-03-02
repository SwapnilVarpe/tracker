// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  int get hour => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get subCategory => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  TaskEntryType get taskEntryType => throw _privateConstructorUsedError;
  bool get isGroupActivity => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get difficulty => throw _privateConstructorUsedError;
  int get satisfaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {int hour,
      String title,
      String category,
      String subCategory,
      DateTime dateTime,
      TaskEntryType taskEntryType,
      bool isGroupActivity,
      int duration,
      int difficulty,
      int satisfaction});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? title = null,
    Object? category = null,
    Object? subCategory = null,
    Object? dateTime = null,
    Object? taskEntryType = null,
    Object? isGroupActivity = null,
    Object? duration = null,
    Object? difficulty = null,
    Object? satisfaction = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subCategory: null == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskEntryType: null == taskEntryType
          ? _value.taskEntryType
          : taskEntryType // ignore: cast_nullable_to_non_nullable
              as TaskEntryType,
      isGroupActivity: null == isGroupActivity
          ? _value.isGroupActivity
          : isGroupActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory _$$_ActivityCopyWith(
          _$_Activity value, $Res Function(_$_Activity) then) =
      __$$_ActivityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int hour,
      String title,
      String category,
      String subCategory,
      DateTime dateTime,
      TaskEntryType taskEntryType,
      bool isGroupActivity,
      int duration,
      int difficulty,
      int satisfaction});
}

/// @nodoc
class __$$_ActivityCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$_Activity>
    implements _$$_ActivityCopyWith<$Res> {
  __$$_ActivityCopyWithImpl(
      _$_Activity _value, $Res Function(_$_Activity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? title = null,
    Object? category = null,
    Object? subCategory = null,
    Object? dateTime = null,
    Object? taskEntryType = null,
    Object? isGroupActivity = null,
    Object? duration = null,
    Object? difficulty = null,
    Object? satisfaction = null,
  }) {
    return _then(_$_Activity(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subCategory: null == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskEntryType: null == taskEntryType
          ? _value.taskEntryType
          : taskEntryType // ignore: cast_nullable_to_non_nullable
              as TaskEntryType,
      isGroupActivity: null == isGroupActivity
          ? _value.isGroupActivity
          : isGroupActivity // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Activity implements _Activity {
  const _$_Activity(
      {required this.hour,
      required this.title,
      required this.category,
      required this.subCategory,
      required this.dateTime,
      required this.taskEntryType,
      required this.isGroupActivity,
      required this.duration,
      required this.difficulty,
      required this.satisfaction});

  factory _$_Activity.fromJson(Map<String, dynamic> json) =>
      _$$_ActivityFromJson(json);

  @override
  final int hour;
  @override
  final String title;
  @override
  final String category;
  @override
  final String subCategory;
  @override
  final DateTime dateTime;
  @override
  final TaskEntryType taskEntryType;
  @override
  final bool isGroupActivity;
  @override
  final int duration;
  @override
  final int difficulty;
  @override
  final int satisfaction;

  @override
  String toString() {
    return 'Activity(hour: $hour, title: $title, category: $category, subCategory: $subCategory, dateTime: $dateTime, taskEntryType: $taskEntryType, isGroupActivity: $isGroupActivity, duration: $duration, difficulty: $difficulty, satisfaction: $satisfaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Activity &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.taskEntryType, taskEntryType) ||
                other.taskEntryType == taskEntryType) &&
            (identical(other.isGroupActivity, isGroupActivity) ||
                other.isGroupActivity == isGroupActivity) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hour,
      title,
      category,
      subCategory,
      dateTime,
      taskEntryType,
      isGroupActivity,
      duration,
      difficulty,
      satisfaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      __$$_ActivityCopyWithImpl<_$_Activity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivityToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  const factory _Activity(
      {required final int hour,
      required final String title,
      required final String category,
      required final String subCategory,
      required final DateTime dateTime,
      required final TaskEntryType taskEntryType,
      required final bool isGroupActivity,
      required final int duration,
      required final int difficulty,
      required final int satisfaction}) = _$_Activity;

  factory _Activity.fromJson(Map<String, dynamic> json) = _$_Activity.fromJson;

  @override
  int get hour;
  @override
  String get title;
  @override
  String get category;
  @override
  String get subCategory;
  @override
  DateTime get dateTime;
  @override
  TaskEntryType get taskEntryType;
  @override
  bool get isGroupActivity;
  @override
  int get duration;
  @override
  int get difficulty;
  @override
  int get satisfaction;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      throw _privateConstructorUsedError;
}
