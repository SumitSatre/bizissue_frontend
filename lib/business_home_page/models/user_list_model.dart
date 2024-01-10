import 'package:json_annotation/json_annotation.dart';

part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel {
  String name;
  String userId;

  UserListModel({
    required this.name,
    required this.userId,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);

  UserListModel copyWith({
    String? name,
    String? userId,
  }) {
    return UserListModel(
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }
}
