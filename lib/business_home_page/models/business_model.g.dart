// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      content: json['content'] as String,
      activityCategory: json['activityCategory'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      issueId: json['issueId'] as String?,
      issueTitle: json['issueTitle'] as String?,
      groupId: json['groupId'] as String?,
      groupName: json['groupName'] as String?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'activityCategory': instance.activityCategory,
      'createdDate': instance.createdDate.toIso8601String(),
      'issueId': instance.issueId,
      'issueTitle': instance.issueTitle,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
  contactNumber:
  ContactNumber.fromJson(json['contactNumber'] as Map<String, dynamic>),
  name: json['name'] as String,
  assignedToMeIssues: (json['assignedToMeIssues'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  userId: json['userId'] as String,
  userType: json['userType'] as String,
  activityViewCounter: json['activityViewCounter'] as int? ?? 0,
  role: json['role'] as String,
  subordinates: (json['subordinates'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  activities: (json['activities'] as List<dynamic>?)
      ?.map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
      ?.toList() ?? [],

);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'contactNumber': instance.contactNumber,
  'name': instance.name,
  'assignedToMeIssues': instance.assignedToMeIssues,
  'userId': instance.userId,
  'userType': instance.userType,
  'activityViewCounter': instance.activityViewCounter,
  'role': instance.role,
  'subordinates': instance.subordinates,
  'activities': instance.activities,
};

MyIssues _$MyIssuesFromJson(Map<String, dynamic> json) => MyIssues(
  myIssues: (json['myIssues'] as List<dynamic>)
      .map((e) => IssueShort.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MyIssuesToJson(MyIssues instance) => <String, dynamic>{
  'myIssues': instance.myIssues,
};

MyTeamIssues _$MyTeamIssuesFromJson(Map<String, dynamic> json) => MyTeamIssues(
  myTeamIssues: (json['myTeamIssues'] as List<dynamic>)
      .map((e) => IssueShort.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MyTeamIssuesToJson(MyTeamIssues instance) =>
    <String, dynamic>{
      'myTeamIssues': instance.myTeamIssues,
    };

IssueShort _$IssueShortFromJson(Map<String, dynamic> json) => IssueShort(
  issueId: json['issueId'] as String,
  title: json['title'] as String,
  details: json['details'] as String?,
  deliveryDate: json['deliveryDate'] as String,
  nextFollowUpDate: json['nextFollowUpDate'] as String,
  delayed: json['delayed'] as int,
  isBlocked: json['isBlocked'] as bool,
  isCritical: json['isCritical'] as bool,
);

Map<String, dynamic> _$IssueShortToJson(IssueShort instance) =>
    <String, dynamic>{
      'issueId': instance.issueId,
      'title': instance.title,
      'details': instance.details,
      'deliveryDate': instance.deliveryDate,
      'nextFollowUpDate': instance.nextFollowUpDate,
      'delayed': instance.delayed,
      'isBlocked': instance.isBlocked,
      'isCritical': instance.isCritical,
    };

BusinessInfo _$BusinessInfoFromJson(Map<String, dynamic> json) => BusinessInfo(
  name: json['name'] as String,
  industryType: json['industryType'] as String? ?? '', // Provide a default value for null
  city: json['city'] as String? ?? '',                // Provide a default value for null
  country: json['country'] as String? ?? '',
  businessId: json['_id'] as String,
);

Map<String, dynamic> _$BusinessInfoToJson(BusinessInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'industryType': instance.industryType,
      'city': instance.city,
      'country': instance.country,
      '_id': instance.businessId,
    };

TeamIssue _$TeamIssueFromJson(Map<String, dynamic> json) => TeamIssue(
  nextFollowUpDate: json['nextFollowUpDate'] as String?,
  issues: (json['issues'] as List<dynamic>?)
      ?.map((e) => IssueShort.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TeamIssueToJson(TeamIssue instance) => <String, dynamic>{
  'nextFollowUpDate': instance.nextFollowUpDate,
  'issues': instance.issues,
};

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      business: BusinessInfo.fromJson(json['business'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      myIssues: (json['myIssues'] as List<dynamic>)
          .map((e) => IssueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      myTeamIssues: (json['myTeamIssues'] as List<dynamic>)
          .map((e) => IssueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'business': instance.business,
      'user': instance.user,
      'myIssues': instance.myIssues,
      'myTeamIssues': instance.myTeamIssues,
    };