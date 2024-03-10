// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as int?,
      title: json['title'] as String,
      category: json['category'] as String,
      subCategory: json['subCategory'] as String,
      activityDate: DateTime.parse(json['activityDate'] as String),
      taskEntryType: $enumDecode(_$TaskEntryTypeEnumMap, json['taskEntryType']),
      isGroupActivity: json['isGroupActivity'] as bool,
      duration: json['duration'] as int,
      difficulty: json['difficulty'] as int,
      satisfaction: json['satisfaction'] as int,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'activityDate': instance.activityDate.toIso8601String(),
      'taskEntryType': _$TaskEntryTypeEnumMap[instance.taskEntryType]!,
      'isGroupActivity': instance.isGroupActivity,
      'duration': instance.duration,
      'difficulty': instance.difficulty,
      'satisfaction': instance.satisfaction,
    };

const _$TaskEntryTypeEnumMap = {
  TaskEntryType.planned: 'planned',
  TaskEntryType.actual: 'actual',
};
