class CreateGroupResponseModel {
  String? name;
  List<String>? usersToAddIds;

  CreateGroupResponseModel({
     this.name,
     this.usersToAddIds,
  });

  factory CreateGroupResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponseModel(
      name: json['name'] as String?,
      usersToAddIds: List<String>.from(json['usersToAddIds'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'usersToAddIds': usersToAddIds,
    };
  }

  CreateGroupResponseModel copyWith({
    String? name,
    List<String>? usersToAddIds,
  }) {
    return CreateGroupResponseModel(
      name: name ?? this.name,
      usersToAddIds: usersToAddIds ?? this.usersToAddIds,
    );
  }
}
