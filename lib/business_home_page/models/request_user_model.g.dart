// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUserModel _$RequestUserModelFromJson(Map<String, dynamic> json) =>
    RequestUserModel(
      contactNumber:
          ContactNumber.fromJson(json['contactNumber'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RequestUserModelToJson(RequestUserModel instance) =>
    <String, dynamic>{
      'contactNumber': instance.contactNumber,
      'userId': instance.userId,
      'name': instance.name,
    };
