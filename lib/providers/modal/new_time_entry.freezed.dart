// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewTimeModel {
  int get hour => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get subCategory => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  bool get isFutureEntry => throw _privateConstructorUsedError;
  bool get isNotify => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewTimeModelCopyWith<NewTimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTimeModelCopyWith<$Res> {
  factory $NewTimeModelCopyWith(
          NewTimeModel value, $Res Function(NewTimeModel) then) =
      _$NewTimeModelCopyWithImpl<$Res, NewTimeModel>;
  @useResult
  $Res call(
      {int hour,
      String title,
      String category,
      String subCategory,
      DateTime start,
      DateTime end,
      bool isFutureEntry,
      bool isNotify,
      bool isAllDay});
}

/// @nodoc
class _$NewTimeModelCopyWithImpl<$Res, $Val extends NewTimeModel>
    implements $NewTimeModelCopyWith<$Res> {
  _$NewTimeModelCopyWithImpl(this._value, this._then);

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
    Object? start = null,
    Object? end = null,
    Object? isFutureEntry = null,
    Object? isNotify = null,
    Object? isAllDay = null,
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
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFutureEntry: null == isFutureEntry
          ? _value.isFutureEntry
          : isFutureEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotify: null == isNotify
          ? _value.isNotify
          : isNotify // ignore: cast_nullable_to_non_nullable
              as bool,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewTimeModelCopyWith<$Res>
    implements $NewTimeModelCopyWith<$Res> {
  factory _$$_NewTimeModelCopyWith(
          _$_NewTimeModel value, $Res Function(_$_NewTimeModel) then) =
      __$$_NewTimeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int hour,
      String title,
      String category,
      String subCategory,
      DateTime start,
      DateTime end,
      bool isFutureEntry,
      bool isNotify,
      bool isAllDay});
}

/// @nodoc
class __$$_NewTimeModelCopyWithImpl<$Res>
    extends _$NewTimeModelCopyWithImpl<$Res, _$_NewTimeModel>
    implements _$$_NewTimeModelCopyWith<$Res> {
  __$$_NewTimeModelCopyWithImpl(
      _$_NewTimeModel _value, $Res Function(_$_NewTimeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? title = null,
    Object? category = null,
    Object? subCategory = null,
    Object? start = null,
    Object? end = null,
    Object? isFutureEntry = null,
    Object? isNotify = null,
    Object? isAllDay = null,
  }) {
    return _then(_$_NewTimeModel(
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
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFutureEntry: null == isFutureEntry
          ? _value.isFutureEntry
          : isFutureEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotify: null == isNotify
          ? _value.isNotify
          : isNotify // ignore: cast_nullable_to_non_nullable
              as bool,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NewTimeModel implements _NewTimeModel {
  const _$_NewTimeModel(
      {required this.hour,
      required this.title,
      required this.category,
      required this.subCategory,
      required this.start,
      required this.end,
      required this.isFutureEntry,
      required this.isNotify,
      required this.isAllDay});

  @override
  final int hour;
  @override
  final String title;
  @override
  final String category;
  @override
  final String subCategory;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final bool isFutureEntry;
  @override
  final bool isNotify;
  @override
  final bool isAllDay;

  @override
  String toString() {
    return 'NewTimeModel(hour: $hour, title: $title, category: $category, subCategory: $subCategory, start: $start, end: $end, isFutureEntry: $isFutureEntry, isNotify: $isNotify, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewTimeModel &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.isFutureEntry, isFutureEntry) ||
                other.isFutureEntry == isFutureEntry) &&
            (identical(other.isNotify, isNotify) ||
                other.isNotify == isNotify) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hour, title, category,
      subCategory, start, end, isFutureEntry, isNotify, isAllDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewTimeModelCopyWith<_$_NewTimeModel> get copyWith =>
      __$$_NewTimeModelCopyWithImpl<_$_NewTimeModel>(this, _$identity);
}

abstract class _NewTimeModel implements NewTimeModel {
  const factory _NewTimeModel(
      {required final int hour,
      required final String title,
      required final String category,
      required final String subCategory,
      required final DateTime start,
      required final DateTime end,
      required final bool isFutureEntry,
      required final bool isNotify,
      required final bool isAllDay}) = _$_NewTimeModel;

  @override
  int get hour;
  @override
  String get title;
  @override
  String get category;
  @override
  String get subCategory;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  bool get isFutureEntry;
  @override
  bool get isNotify;
  @override
  bool get isAllDay;
  @override
  @JsonKey(ignore: true)
  _$$_NewTimeModelCopyWith<_$_NewTimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
