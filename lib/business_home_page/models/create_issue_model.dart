import 'package:json_annotation/json_annotation.dart';

part 'create_issue_model.g.dart';

@JsonSerializable()
class CreateIssueModel {
  String title;
  String details;
  String assignedToId;
  String deliveryDate;
  String nextFollowUpDate;

  CreateIssueModel({
    required this.title,
    required this.details,
    required this.assignedToId,
    required this.deliveryDate,
    required this.nextFollowUpDate,
  });

  factory CreateIssueModel.fromJson(Map<String, dynamic> json) =>
      _$CreateIssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateIssueModelToJson(this);

  CreateIssueModel copyWith({
    String? title,
    String? details,
    String? assignedToId,
    String? deliveryDate,
    String? nextFollowUpDate,
  }) {
    return CreateIssueModel(
      title: title ?? this.title,
      details: details ?? this.details,
      assignedToId: assignedToId ?? this.assignedToId,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      nextFollowUpDate: nextFollowUpDate ?? this.nextFollowUpDate,
    );
  }
}
