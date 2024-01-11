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
