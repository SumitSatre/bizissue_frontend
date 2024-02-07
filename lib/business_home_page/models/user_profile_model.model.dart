import 'package:bizissue/home/models/user_model.dart';

class User {
  final ContactNumber contactNumber;
  final int totalRating;
  final String name;
  final String userId;
  final String userType;
  final String role;
  final String lastSeen;

  User({
    required this.contactNumber,
    required this.totalRating,
    required this.name,
    required this.userId,
    required this.userType,
    required this.role,
    required this.lastSeen,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
      totalRating: json['totalRating'],
      name: json['name'],
      userId: json['userId'],
      userType: json['userType'],
      role: json['role'],
      lastSeen: json['last_seen'],
    );
  }
}

class Count {
  final int totalIssuesCount;
  final int delayedCount;
  final int blockedCount;
  final int criticalCount;
  final int expiredDeliveryDateCount;
  final int expiredNextFollowUpDateCount;

  Count({
    required this.totalIssuesCount,
    required this.delayedCount,
    required this.blockedCount,
    required this.criticalCount,
    required this.expiredDeliveryDateCount,
    required this.expiredNextFollowUpDateCount,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      totalIssuesCount: json['totalIssuesCount'],
      delayedCount: json['delayedCount'],
      blockedCount: json['blockedCount'],
      criticalCount: json['criticalCount'],
      expiredDeliveryDateCount: json['expiredDeliveryDateCount'],
      expiredNextFollowUpDateCount: json['expiredNextFollowUpDateCount'],
    );
  }
}

class UserProfile {
  final User user;
  final Count count;

  UserProfile({
    required this.user,
    required this.count,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      user: User.fromJson(json['user']),
      count: Count.fromJson(json['count']),
    );
  }
}