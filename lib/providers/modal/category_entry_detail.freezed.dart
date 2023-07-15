// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_entry_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategoryEntryDetail {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  CategoryType get categoryType => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryEntryDetailCopyWith<CategoryEntryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEntryDetailCopyWith<$Res> {
  factory $CategoryEntryDetailCopyWith(
          CategoryEntryDetail value, $Res Function(CategoryEntryDetail) then) =
      _$CategoryEntryDetailCopyWithImpl<$Res, CategoryEntryDetail>;
  @useResult
  $Res call(
      {String start, String end, CategoryType categoryType, String category});
}

/// @nodoc
class _$CategoryEntryDetailCopyWithImpl<$Res, $Val extends CategoryEntryDetail>
    implements $CategoryEntryDetailCopyWith<$Res> {
  _$CategoryEntryDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? categoryType = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      categoryType: null == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategoryEntryDetailCopyWith<$Res>
    implements $CategoryEntryDetailCopyWith<$Res> {
  factory _$$_CategoryEntryDetailCopyWith(_$_CategoryEntryDetail value,
          $Res Function(_$_CategoryEntryDetail) then) =
      __$$_CategoryEntryDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String start, String end, CategoryType categoryType, String category});
}

/// @nodoc
class __$$_CategoryEntryDetailCopyWithImpl<$Res>
    extends _$CategoryEntryDetailCopyWithImpl<$Res, _$_CategoryEntryDetail>
    implements _$$_CategoryEntryDetailCopyWith<$Res> {
  __$$_CategoryEntryDetailCopyWithImpl(_$_CategoryEntryDetail _value,
      $Res Function(_$_CategoryEntryDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? categoryType = null,
    Object? category = null,
  }) {
    return _then(_$_CategoryEntryDetail(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      categoryType: null == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CategoryEntryDetail implements _CategoryEntryDetail {
  const _$_CategoryEntryDetail(
      {required this.start,
      required this.end,
      required this.categoryType,
      required this.category});

  @override
  final String start;
  @override
  final String end;
  @override
  final CategoryType categoryType;
  @override
  final String category;

  @override
  String toString() {
    return 'CategoryEntryDetail(start: $start, end: $end, categoryType: $categoryType, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CategoryEntryDetail &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.categoryType, categoryType) ||
                other.categoryType == categoryType) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, start, end, categoryType, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoryEntryDetailCopyWith<_$_CategoryEntryDetail> get copyWith =>
      __$$_CategoryEntryDetailCopyWithImpl<_$_CategoryEntryDetail>(
          this, _$identity);
}

abstract class _CategoryEntryDetail implements CategoryEntryDetail {
  const factory _CategoryEntryDetail(
      {required final String start,
      required final String end,
      required final CategoryType categoryType,
      required final String category}) = _$_CategoryEntryDetail;

  @override
  String get start;
  @override
  String get end;
  @override
  CategoryType get categoryType;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$_CategoryEntryDetailCopyWith<_$_CategoryEntryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
