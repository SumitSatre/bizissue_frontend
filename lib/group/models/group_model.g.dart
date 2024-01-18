// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      usersIds:
          (json['usersIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdDate: json['createdDate'] as String,
      issues: (json['issues'] as List<dynamic>)
          .map((e) => IssueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'name': instance.name,
      'usersIds': instance.usersIds,
      'createdDate': instance.createdDate,
      'issues': instance.issues,
    };
