// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactNumber _$ContactNumberFromJson(Map<String, dynamic> json) =>
    ContactNumber(
      countryCode: json['countryCode'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$ContactNumberToJson(ContactNumber instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'number': instance.number,
    };

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      name: json['name'] as String,
      userType: json['userType'] as String,
      businessId: json['businessId'] as String,
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'name': instance.name,
      'userType': instance.userType,
      'businessId': instance.businessId,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      jobTitle: json['jobTitle'] as String,
      email: json['email'] as String,
      contactNumber:
          ContactNumber.fromJson(json['contactNumber'] as Map<String, dynamic>),
      businesses: (json['businesses'] as List<dynamic>)
          .map((e) => Business.fromJson(e as Map<String, dynamic>))
          .toList(),
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'jobTitle': instance.jobTitle,
      'email': instance.email,
      'contactNumber': instance.contactNumber,
      'businesses': instance.businesses,
      'notifications': instance.notifications,
    };
