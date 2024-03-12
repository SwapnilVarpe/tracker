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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get subCategory => throw _privateConstructorUsedError;
  DateTime get activityDate => throw _privateConstructorUsedError;
  TaskEntryType get taskEntryType => throw _privateConstructorUsedError;
  int get isGroupActivity => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  double get difficulty => throw _privateConstructorUsedError;
  double get satisfaction => throw _privateConstructorUsedError;

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
      {int? id,
      String title,
      String category,
      String subCategory,
      DateTime activityDate,
      TaskEntryType taskEntryType,
      int isGroupActivity,
      double duration,
      double difficulty,
      double satisfaction});
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
    Object? id = freezed,
    Object? title = null,
    Object? category = null,
    Object? subCategory = null,
    Object? activityDate = null,
    Object? taskEntryType = null,
    Object? isGroupActivity = null,
    Object? duration = null,
    Object? difficulty = null,
    Object? satisfaction = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      activityDate: null == activityDate
          ? _value.activityDate
          : activityDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskEntryType: null == taskEntryType
          ? _value.taskEntryType
          : taskEntryType // ignore: cast_nullable_to_non_nullable
              as TaskEntryType,
      isGroupActivity: null == isGroupActivity
          ? _value.isGroupActivity
          : isGroupActivity // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      String category,
      String subCategory,
      DateTime activityDate,
      TaskEntryType taskEntryType,
      int isGroupActivity,
      double duration,
      double difficulty,
      double satisfaction});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? category = null,
    Object? subCategory = null,
    Object? activityDate = null,
    Object? taskEntryType = null,
    Object? isGroupActivity = null,
    Object? duration = null,
    Object? difficulty = null,
    Object? satisfaction = null,
  }) {
    return _then(_$ActivityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      activityDate: null == activityDate
          ? _value.activityDate
          : activityDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskEntryType: null == taskEntryType
          ? _value.taskEntryType
          : taskEntryType // ignore: cast_nullable_to_non_nullable
              as TaskEntryType,
      isGroupActivity: null == isGroupActivity
          ? _value.isGroupActivity
          : isGroupActivity // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityImpl implements _Activity {
  const _$ActivityImpl(
      {this.id,
      required this.title,
      required this.category,
      required this.subCategory,
      required this.activityDate,
      required this.taskEntryType,
      required this.isGroupActivity,
      required this.duration,
      required this.difficulty,
      required this.satisfaction});

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String category;
  @override
  final String subCategory;
  @override
  final DateTime activityDate;
  @override
  final TaskEntryType taskEntryType;
  @override
  final int isGroupActivity;
  @override
  final double duration;
  @override
  final double difficulty;
  @override
  final double satisfaction;

  @override
  String toString() {
    return 'Activity(id: $id, title: $title, category: $category, subCategory: $subCategory, activityDate: $activityDate, taskEntryType: $taskEntryType, isGroupActivity: $isGroupActivity, duration: $duration, difficulty: $difficulty, satisfaction: $satisfaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.activityDate, activityDate) ||
                other.activityDate == activityDate) &&
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
      id,
      title,
      category,
      subCategory,
      activityDate,
      taskEntryType,
      isGroupActivity,
      duration,
      difficulty,
      satisfaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  const factory _Activity(
      {final int? id,
      required final String title,
      required final String category,
      required final String subCategory,
      required final DateTime activityDate,
      required final TaskEntryType taskEntryType,
      required final int isGroupActivity,
      required final double duration,
      required final double difficulty,
      required final double satisfaction}) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String get category;
  @override
  String get subCategory;
  @override
  DateTime get activityDate;
  @override
  TaskEntryType get taskEntryType;
  @override
  int get isGroupActivity;
  @override
  double get duration;
  @override
  double get difficulty;
  @override
  double get satisfaction;
  @override
  @JsonKey(ignore: true)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
