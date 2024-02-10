import 'package:bizissue/home/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_user_model.g.dart';

@JsonSerializable()
class RequestUserModel {
  ContactNumber contactNumber;
  String userId;
  String name;

  RequestUserModel({
    required this.contactNumber,
    required this.userId,
    required this.name,
  });

  factory RequestUserModel.fromJson(Map<String, dynamic> json) =>
      _$RequestUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUserModelToJson(this);

  RequestUserModel copyWith({
    ContactNumber? contactNumber,
    String? userId,
    String? name,
  }) {
    return RequestUserModel(
      contactNumber: contactNumber ?? this.contactNumber,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}

class DeclinedRequestUser {
  final String userId;
  final String name;
  final String reason;
  final String declinedDate;
  final ContactNumber contactNumber;

  DeclinedRequestUser({
    required this.userId,
    required this.name,
    required this.reason,
    required this.declinedDate,
    required this.contactNumber,
  });

  factory DeclinedRequestUser.fromJson(Map<String, dynamic> json) {
    return DeclinedRequestUser(
      userId: json['userId'],
      name: json['name'],
      reason: json['reason'],
      declinedDate: json['declinedDate'],
      contactNumber: ContactNumber.fromJson(json['contactNumber']),
    );
  }
}