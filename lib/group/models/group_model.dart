import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel {
  String groupId;
  String name;
  List<String> usersIds;
  String createdDate;
  List<IssueModel> issues;

  GroupModel({
    required this.groupId,
    required this.name,
    required this.usersIds,
    required this.createdDate,
    required this.issues,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  GroupModel copyWith({
    String? groupId,
    String? name,
    List<String>? usersIds,
    String? createdDate,
    List<IssueModel>? issues,
  }) {
    return GroupModel(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      usersIds: usersIds ?? this.usersIds,
      createdDate: createdDate ?? this.createdDate,
      issues: issues ?? this.issues,
    );
  }
}