import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

class NotificationModel {
  final String content;
  final String notificationCategory;
  final DateTime createdDate;
  final String? businessName;
  final String? businessId;

  NotificationModel({
    required this.content,
    required this.notificationCategory,
    required this.createdDate,
     this.businessName,
     this.businessId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      content: json['content'] as String,
      notificationCategory: json['notificationCategory'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      businessName: json['businessName'] as String?, // Nullable
      businessId: json['businessId'] as String?, // Nullable
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'notificationCategory': notificationCategory,
      'createdDate': createdDate.toIso8601String(),
      'businessName': businessName,
      'businessId': businessId,
    };
  }
}


@JsonSerializable()
class ContactNumber {
  String countryCode;
  String number;

  ContactNumber({
    required this.countryCode,
    required this.number,
  });

  factory ContactNumber.fromJson(Map<String, dynamic> json) =>
      _$ContactNumberFromJson(json);

  Map<String, dynamic> toJson() => _$ContactNumberToJson(this);

  ContactNumber copyWith({
    String? countryCode,
    String? number,
  }) {
    return ContactNumber(
      countryCode: countryCode ?? this.countryCode,
      number: number ?? this.number,
    );
  }
}

@JsonSerializable()
class Business {
  String name;
  String userType; // Assuming 'Insider' or 'Outsider'
  String businessId;

  Business({
    required this.name,
    required this.userType,
    required this.businessId,
  });

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);

  Business copyWith({
    String? name,
    String? userType,
    String? businessId,
  }) {
    return Business(
      name: name ?? this.name,
      userType: userType ?? this.userType,
      businessId: businessId ?? this.businessId,
    );
  }
}

@JsonSerializable()
class UserModel {
  String id;
  String name;
  String jobTitle;
  String email;
  ContactNumber contactNumber;
  List<Business> businesses;
  List<NotificationModel> notifications;

  UserModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.contactNumber,
    required this.businesses,
    required this.notifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? jobTitle,
    String? email,
    ContactNumber? contactNumber,
    List<Business>? businesses,
    List<NotificationModel>? notifications
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      businesses: businesses ?? this.businesses,
      notifications: notifications ?? this.notifications,
    );
  }
}
