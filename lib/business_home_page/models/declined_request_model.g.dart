// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declined_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclinedRequestModel _$DeclinedRequestModelFromJson(
        Map<String, dynamic> json) =>
    DeclinedRequestModel(
      contactNumber:
          ContactNumber.fromJson(json['contactNumber'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      name: json['name'] as String,
      reason: json['reason'] as String,
      declinedDate: json['declinedDate'] as String,
    );

Map<String, dynamic> _$DeclinedRequestModelToJson(
        DeclinedRequestModel instance) =>
    <String, dynamic>{
      'contactNumber': instance.contactNumber,
      'userId': instance.userId,
      'name': instance.name,
      'reason': instance.reason,
      'declinedDate': instance.declinedDate,
    };
