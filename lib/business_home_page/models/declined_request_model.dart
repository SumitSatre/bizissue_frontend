import 'package:bizissue/home/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declined_request_model.g.dart';

@JsonSerializable()
class DeclinedRequestModel {
  ContactNumber contactNumber;
  String userId;
  String name;
  String reason;
  String declinedDate;

  DeclinedRequestModel({
    required this.contactNumber,
    required this.userId,
    required this.name,
    required this.reason,
    required this.declinedDate,
  });

  factory DeclinedRequestModel.fromJson(Map<String, dynamic> json) => _$DeclinedRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeclinedRequestModelToJson(this);
}
