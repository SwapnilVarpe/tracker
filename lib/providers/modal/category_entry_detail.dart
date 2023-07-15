import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tracker/constants.dart';

part 'category_entry_detail.freezed.dart';

@freezed
class CategoryEntryDetail with _$CategoryEntryDetail {
  const factory CategoryEntryDetail(
      {required String start,
      required String end,
      required CategoryType categoryType,
      required String category}) = _CategoryEntryDetail;
}
