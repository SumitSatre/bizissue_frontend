import 'package:bizissue/home/models/user_model.dart';
import 'dart:convert'; // for json.decode if needed

class User {
  final ContactNumber contactNumber;
  final double totalRating;
  final String name;
  final String userId;
  final String userType;
  final String role;
  final DateTime lastSeen;
  final List<RatingModel> rating;

  User({
    required this.contactNumber,
    required this.totalRating,
    required this.name,
    required this.userId,
    required this.userType,
    required this.role,
    required this.lastSeen,
    required this.rating,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
      totalRating: json['totalRating'] is int
          ? (json['totalRating'] as int).toDouble()
          : json['totalRating'],
      name: json['name'],
      userId: json['userId'],
      userType: json['userType'],
      role: json['role'],
      lastSeen: DateTime.parse(json['lastSeen']),
      rating: json['rating'] == null
          ? []
          : List<RatingModel>.from(json['rating'].map((x) =>
              RatingModel.fromJson(
                  x))), // Provide an empty list if 'rating' key is not present
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

class RatingModel {
  final GivenBy givenBy;
  final int rating;
  final String message;
  final DateTime date;
  final String id;

  RatingModel({
    required this.givenBy,
    required this.rating,
    required this.message,
    required this.date,
    required this.id,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      givenBy: GivenBy.fromJson(json['givenBy']),
      rating: json['rating'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      id: json['_id'],
    );
  }
}

class GivenBy {
  final String name;
  final String id;

  GivenBy({
    required this.name,
    required this.id,
  });

  factory GivenBy.fromJson(Map<String, dynamic> json) {
    return GivenBy(
      name: json['name'],
      id: json['id'],
    );
  }
}
