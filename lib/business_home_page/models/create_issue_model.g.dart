// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateIssueModel _$CreateIssueModelFromJson(Map<String, dynamic> json) =>
    CreateIssueModel(
      title: json['title'] as String?,
      details: json['details'] as String?,
      assignedToId: json['assignedToId'] as String?,
      deliveryDate: json['deliveryDate'] as String?,
      nextFollowUpDate: json['nextFollowUpDate'] as String?,
    );

Map<String, dynamic> _$CreateIssueModelToJson(CreateIssueModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'assignedToId': instance.assignedToId,
      'deliveryDate': instance.deliveryDate,
      'nextFollowUpDate': instance.nextFollowUpDate,
    };
