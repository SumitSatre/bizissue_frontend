// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blocked _$BlockedFromJson(Map<String, dynamic> json) => Blocked(
      isBlocked: json['isBlocked'] as bool,
      blockedBy: BlockedBy.fromJson(json['blockedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockedToJson(Blocked instance) => <String, dynamic>{
      'isBlocked': instance.isBlocked,
      'blockedBy': instance.blockedBy,
    };

BlockedBy _$BlockedByFromJson(Map<String, dynamic> json) => BlockedBy(
      name: json['name'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BlockedByToJson(BlockedBy instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Critical _$CriticalFromJson(Map<String, dynamic> json) => Critical(
      isCritical: json['isCritical'] as bool,
      markedCriticalBy:
          CriticalBy.fromJson(json['markedCriticalBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CriticalToJson(Critical instance) => <String, dynamic>{
      'isCritical': instance.isCritical,
      'markedCriticalBy': instance.markedCriticalBy,
    };

CriticalBy _$CriticalByFromJson(Map<String, dynamic> json) => CriticalBy(
      name: json['name'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CriticalByToJson(CriticalBy instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

AssignedTo _$AssignedToFromJson(Map<String, dynamic> json) => AssignedTo(
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$AssignedToToJson(AssignedTo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      issueId: json['issueId'] as String,
      title: json['title'] as String,
      details: json['details'] as String,
      blocked: Blocked.fromJson(json['blocked'] as Map<String, dynamic>),
      critical: Critical.fromJson(json['critical'] as Map<String, dynamic>),
      delayed: json['delayed'] as int,
      createdBy: CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      assignedTo:
          AssignedTo.fromJson(json['assignedTo'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as String,
      deliveryDate: json['deliveryDate'] as String,
      nextFollowUpDate: json['nextFollowUpDate'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'issueId': instance.issueId,
      'title': instance.title,
      'details': instance.details,
      'blocked': instance.blocked,
      'critical': instance.critical,
      'delayed': instance.delayed,
      'createdBy': instance.createdBy,
      'assignedTo': instance.assignedTo,
      'createdDate': instance.createdDate,
      'deliveryDate': instance.deliveryDate,
      'nextFollowUpDate': instance.nextFollowUpDate,
      'status': instance.status,
    };
