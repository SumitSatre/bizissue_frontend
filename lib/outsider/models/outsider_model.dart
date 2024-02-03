import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/home/models/user_model.dart';

class OutsiderInfo {
  final Business business;
  final User user;
  final List<IssueModel> issues;

  OutsiderInfo({
    required this.business,
    required this.user,
    required this.issues,
  });

  factory OutsiderInfo.fromJson(Map<String, dynamic> json) {
    return OutsiderInfo(
      business: Business.fromJson(json['business']),
      user: User.fromJson(json['user']),
      issues: List<IssueModel>.from(json['issues'].map((x) => IssueModel.fromJson(x))),
    );
  }
}

class Business {
  final String id;
  final String name;
  final String? industryType;
  final String? city;
  final String? country;
  final List<User> users;

  Business({
    required this.id,
    required this.name,
    this.industryType,
    this.city,
    this.country,
    required this.users,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      name: json['name'],
      industryType: json['industryType'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
      users: (json['users'] as List<dynamic>?)
          ?.map((userJson) => User.fromJson(userJson))
          ?.toList() ?? [], // Handle null users field
    );
  }

}

class User {
  final ContactNumber contactNumber;
  final String name;
  final List<String> assignedToMeIssues;
  final String userId;
  final String userType;
  final String role;
  final String parentId;
  final int activityViewCounter;
  final String id;
  final List<dynamic> activities;

  User({
    required this.contactNumber,
    required this.name,
    required this.assignedToMeIssues,
    required this.userId,
    required this.userType,
    required this.role,
    required this.parentId,
    required this.activityViewCounter,
    required this.id,
    required this.activities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
      name: json['name'],
      assignedToMeIssues: List<String>.from(json['assignedToMeIssues']),
      userId: json['userId'],
      userType: json['userType'],
      role: json['role'],
      parentId: json['parentId'],
      activityViewCounter: json['activityViewCounter'] ?? 0,
      id: json['_id'],
      activities: List<dynamic>.from(json['activities'] ?? []) ,
    );
  }
}
