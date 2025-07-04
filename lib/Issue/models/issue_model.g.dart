// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactNumber contactNumber = ContactNumber(countryCode: "+91", number: "1111111111");

Blocked _$BlockedFromJson(Map<String, dynamic> json) => Blocked(
      isBlocked: json['isBlocked'] as bool,
      blockedBy: json['blockedBy'] == null
          ? null
          : BlockedBy.fromJson(json['blockedBy'] as Map<String, dynamic>),
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
      markedCriticalBy: json['markedCriticalBy'] == null
          ? null
          : CriticalBy.fromJson(
              json['markedCriticalBy'] as Map<String, dynamic>),
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

OutsiderShort _$OutsiderShortFromJson(Map<String, dynamic> json) =>
    OutsiderShort(
      name: json['name'] as String?,
      id: json['id'] as String?,
      contactNumber: json['contactNumber'] != null
    ? ContactNumberOutsider.fromJson(json['contactNumber'] as Map<String, dynamic>)
    : ContactNumberOutsider(countryCode: "dummy", number: "dummy"),

    );

Map<String, dynamic> _$OutsiderShortToJson(OutsiderShort instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'contactNumber': instance.contactNumber
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

IssueModel _$IssueModelFromJson(Map<String, dynamic> json) => IssueModel(
      issueId: json['issueId'] as String,
      title: json['title'] as String,
      details: json['details'] as String?,
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
      isAssignToOutsider: json['isAssignToOutsider'] as bool,
      outsider: json['outsider'] == null
          ? null
          : OutsiderShort.fromJson(json['outsider'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IssueModelToJson(IssueModel instance) =>
    <String, dynamic>{
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
      'isAssignToOutsider': instance.isAssignToOutsider,
      'outsider': instance.outsider,
    };

GroupIssue _$GroupIssueFromJson(Map<String, dynamic> json) => GroupIssue(
  date: json['date'] as String?,
      issues: (json['issues'] as List<dynamic>?)
          ?.map((e) => IssueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupIssueToJson(GroupIssue instance) =>
    <String, dynamic>{
      'date': instance.date,
      'issues': instance.issues,
    };
