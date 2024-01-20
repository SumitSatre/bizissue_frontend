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

class GroupUsersIdModel {
  String groupId;
  String name;
  List<String> usersIds;

  GroupUsersIdModel({
    required this.groupId,
    required this.name,
    required this.usersIds,
  });

  factory GroupUsersIdModel.fromJson(Map<String, dynamic> json) {
    return GroupUsersIdModel(
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      usersIds: (json['usersIds'] as List).map((id) => id as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'name': name,
      'usersIds': usersIds,
    };
  }

  GroupUsersIdModel copyWith({
    String? groupId,
    String? name,
    List<String>? usersIds,
  }) {
    return GroupUsersIdModel(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      usersIds: usersIds ?? this.usersIds,
    );
  }

}
