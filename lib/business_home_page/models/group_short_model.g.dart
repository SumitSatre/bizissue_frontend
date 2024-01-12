// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_short_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupShortModel _$GroupShortModelFromJson(Map<String, dynamic> json) =>
    GroupShortModel(
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$GroupShortModelToJson(GroupShortModel instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'name': instance.name,
      'createdDate': instance.createdDate,
    };
