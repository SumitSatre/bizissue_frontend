// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBusinessModel _$CreateBusinessModelFromJson(Map<String, dynamic> json) =>
    CreateBusinessModel(
      name: json['name'] as String?,
      industryType: json['industryType'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$CreateBusinessModelToJson(
        CreateBusinessModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'industryType': instance.industryType,
      'city': instance.city,
      'country': instance.country,
    };
