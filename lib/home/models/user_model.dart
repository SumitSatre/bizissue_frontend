import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

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

  UserModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.contactNumber,
    required this.businesses,
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
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      businesses: businesses ?? this.businesses,
    );
  }
}
