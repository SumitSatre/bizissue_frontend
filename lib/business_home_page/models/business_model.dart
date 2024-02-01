import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../home/models/user_model.dart';

part 'business_model.g.dart';

@JsonSerializable()
class ActivityModel {
  String content;
  String activityCategory;
  DateTime createdDate;
  String? issueId;
  String? issueTitle;
  String? groupId;
  String? groupName;

  ActivityModel({
    required this.content,
    required this.activityCategory,
    required this.createdDate,
    this.issueId,
    this.issueTitle,
    this.groupId,
    this.groupName,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}

@JsonSerializable()
class User {
  ContactNumber contactNumber;
  String name;
  List<String> assignedToMeIssues;
  String userId;
  String userType;
  int activityViewCounter;
  String role;
  List<String> subordinates;
  List<ActivityModel> activities;

  User({
    required this.contactNumber,
    required this.name,
    required this.assignedToMeIssues,
    required this.userId,
    required this.userType,
    required this.activityViewCounter,
    required this.role,
    required this.subordinates,
    required this.activities,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    ContactNumber? contactNumber,
    String? name,
    List<String>? assignedToMeIssues,
    String? userId,
    String? userType,
    int? activityViewCounter,
    String? role,
    List<String>? subordinates,
    List<ActivityModel>? activities

  }) {
    return User(
      contactNumber: contactNumber ?? this.contactNumber,
      name: name ?? this.name,
      assignedToMeIssues: assignedToMeIssues ?? this.assignedToMeIssues,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      activityViewCounter: activityViewCounter ?? this.activityViewCounter,
      role: role ?? this.role,
      subordinates: subordinates ?? this.subordinates,
      activities: activities ?? this.activities,
    );
  }
}

@JsonSerializable()
class MyIssues {
  List<IssueShort> myIssues;

  MyIssues({
    required this.myIssues,
  });

  factory MyIssues.fromJson(Map<String, dynamic> json) =>
      _$MyIssuesFromJson(json);

  Map<String, dynamic> toJson() => _$MyIssuesToJson(this);

  MyIssues copyWith({
    List<IssueShort>? myIssues,
  }) {
    return MyIssues(
      myIssues: myIssues ?? this.myIssues,
    );
  }
}

@JsonSerializable()
class MyTeamIssues {
  List<IssueShort> myTeamIssues;

  MyTeamIssues({
    required this.myTeamIssues,
  });

  factory MyTeamIssues.fromJson(Map<String, dynamic> json) =>
      _$MyTeamIssuesFromJson(json);

  Map<String, dynamic> toJson() => _$MyTeamIssuesToJson(this);

  MyTeamIssues copyWith({
    List<IssueShort>? myTeamIssues,
  }) {
    return MyTeamIssues(
      myTeamIssues: myTeamIssues ?? this.myTeamIssues,
    );
  }
}

@JsonSerializable()
class IssueShort {
  String issueId;
  String title;
  String? details;
  String deliveryDate;
  String nextFollowUpDate;
  int delayed;
  bool isBlocked;
  bool isCritical;

  IssueShort({
    required this.issueId,
    required this.title,
    this.details,
    required this.deliveryDate,
    required this.nextFollowUpDate,
    required this.delayed,
    required this.isBlocked,
    required this.isCritical,
  });

  factory IssueShort.fromJson(Map<String, dynamic> json) =>
      _$IssueShortFromJson(json);

  Map<String, dynamic> toJson() => _$IssueShortToJson(this);

  IssueShort copyWith({
    String? issueId,
    String? title,
    String? details,
    String? deliveryDate,
    String? nextFollowUpDate,
    int? delayed,
    bool? isBlocked,
    bool? isCritical,
  }) {
    return IssueShort(
      issueId: issueId ?? this.issueId,
      title: title ?? this.title,
      details: details ?? this.details,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      nextFollowUpDate: nextFollowUpDate ?? this.nextFollowUpDate,
      delayed: delayed ?? this.delayed,
      isBlocked: isBlocked ?? this.isBlocked,
      isCritical: isCritical ?? this.isCritical,
    );
  }
}

@JsonSerializable()
class BusinessInfo {
  String name;
  String industryType; // Change from String? to String
  String city;         // Change from String? to String
  String country;      // Change from String? to String
  String businessId;

  BusinessInfo({
    required this.name,
    required this.industryType,
    required this.city,
    required this.country,
    required this.businessId,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) =>
      _$BusinessInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessInfoToJson(this);

  BusinessInfo copyWith({
    String? name,
    String? industryType,
    String? city,
    String? country,
    String? businessId,
  }) {
    return BusinessInfo(
      name: name ?? this.name,
      industryType: industryType ?? this.industryType,
      city: city ?? this.city,
      country: country ?? this.country,
      businessId: businessId ?? this.businessId,
    );
  }
}

@JsonSerializable()
class TeamIssue {
  String? nextFollowUpDate;
  List<IssueShort>? issues;

  TeamIssue({ this.nextFollowUpDate,  this.issues});

  factory TeamIssue.fromJson(Map<String, dynamic> json) =>
      _$TeamIssueFromJson(json);

  Map<String, dynamic> toJson() => _$TeamIssueToJson(this);
}

@JsonSerializable()
class BusinessModel {
  BusinessInfo business;
  User user;
  List<IssueModel> myIssues;
  List<IssueModel> myTeamIssues;

  BusinessModel({
    required this.business,
    required this.user,
    required this.myIssues,
    required this.myTeamIssues,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);

  BusinessModel copyWith({
    BusinessInfo? business,
    User? user,
    List<IssueModel>? myIssues,
    List<IssueModel>? myTeamIssues
  }) {
    return BusinessModel(
      business: business ?? this.business,
      user: user ?? this.user,
      myIssues: myIssues ?? this.myIssues,
      myTeamIssues: myTeamIssues ?? this.myTeamIssues,
    );
  }
}
