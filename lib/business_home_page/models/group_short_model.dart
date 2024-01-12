import 'package:json_annotation/json_annotation.dart';

part 'group_short_model.g.dart';

@JsonSerializable()
class GroupShortModel {
  String groupId;
  String name;
  String createdDate;

  GroupShortModel({
    required this.groupId,
    required this.name,
    required this.createdDate,
  });

  factory GroupShortModel.fromJson(Map<String, dynamic> json) => _$GroupShortModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupShortModelToJson(this);

  GroupShortModel copyWith({
    String? groupId,
    String? name,
    String? createdDate,
  }) {
    return GroupShortModel(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
