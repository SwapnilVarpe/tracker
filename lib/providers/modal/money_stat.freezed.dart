// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoneyStat {
  String get month => throw _privateConstructorUsedError;
  CategoryType get categoryType => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get subCategory => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<Category> get categories => throw _privateConstructorUsedError;
  List<Entry> get entries => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoneyStatCopyWith<MoneyStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyStatCopyWith<$Res> {
  factory $MoneyStatCopyWith(MoneyStat value, $Res Function(MoneyStat) then) =
      _$MoneyStatCopyWithImpl<$Res, MoneyStat>;
  @useResult
  $Res call(
      {String month,
      CategoryType categoryType,
      String category,
      String subCategory,
      double total,
      List<Category> categories,
      List<Entry> entries});
}

/// @nodoc
class _$MoneyStatCopyWithImpl<$Res, $Val extends MoneyStat>
    implements $MoneyStatCopyWith<$Res> {
  _$MoneyStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? categoryType = null,
    Object? category = null,
    Object? subCategory = null,
    Object? total = null,
    Object? categories = null,
    Object? entries = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      categoryType: null == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subCategory: null == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoneyStatCopyWith<$Res> implements $MoneyStatCopyWith<$Res> {
  factory _$$_MoneyStatCopyWith(
          _$_MoneyStat value, $Res Function(_$_MoneyStat) then) =
      __$$_MoneyStatCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String month,
      CategoryType categoryType,
      String category,
      String subCategory,
      double total,
      List<Category> categories,
      List<Entry> entries});
}

/// @nodoc
class __$$_MoneyStatCopyWithImpl<$Res>
    extends _$MoneyStatCopyWithImpl<$Res, _$_MoneyStat>
    implements _$$_MoneyStatCopyWith<$Res> {
  __$$_MoneyStatCopyWithImpl(
      _$_MoneyStat _value, $Res Function(_$_MoneyStat) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? categoryType = null,
    Object? category = null,
    Object? subCategory = null,
    Object? total = null,
    Object? categories = null,
    Object? entries = null,
  }) {
    return _then(_$_MoneyStat(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      categoryType: null == categoryType
          ? _value.categoryType
          : categoryType // ignore: cast_nullable_to_non_nullable
              as CategoryType,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subCategory: null == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ));
  }
}

/// @nodoc

class _$_MoneyStat with DiagnosticableTreeMixin implements _MoneyStat {
  const _$_MoneyStat(
      {required this.month,
      required this.categoryType,
      required this.category,
      required this.subCategory,
      required this.total,
      required final List<Category> categories,
      required final List<Entry> entries})
      : _categories = categories,
        _entries = entries;

  @override
  final String month;
  @override
  final CategoryType categoryType;
  @override
  final String category;
  @override
  final String subCategory;
  @override
  final double total;
  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Entry> _entries;
  @override
  List<Entry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoneyStat(month: $month, categoryType: $categoryType, category: $category, subCategory: $subCategory, total: $total, categories: $categories, entries: $entries)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoneyStat'))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('categoryType', categoryType))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('subCategory', subCategory))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('entries', entries));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoneyStat &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.categoryType, categoryType) ||
                other.categoryType == categoryType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      categoryType,
      category,
      subCategory,
      total,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_entries));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoneyStatCopyWith<_$_MoneyStat> get copyWith =>
      __$$_MoneyStatCopyWithImpl<_$_MoneyStat>(this, _$identity);
}

abstract class _MoneyStat implements MoneyStat {
  const factory _MoneyStat(
      {required final String month,
      required final CategoryType categoryType,
      required final String category,
      required final String subCategory,
      required final double total,
      required final List<Category> categories,
      required final List<Entry> entries}) = _$_MoneyStat;

  @override
  String get month;
  @override
  CategoryType get categoryType;
  @override
  String get category;
  @override
  String get subCategory;
  @override
  double get total;
  @override
  List<Category> get categories;
  @override
  List<Entry> get entries;
  @override
  @JsonKey(ignore: true)
  _$$_MoneyStatCopyWith<_$_MoneyStat> get copyWith =>
      throw _privateConstructorUsedError;
}
