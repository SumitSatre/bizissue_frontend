class UserRecord {
  final String name;
  final String userId;
  final String userType;
  String role; // Change from final to mutable

  UserRecord({
    required this.name,
    required this.userId,
    required this.userType,
    required this.role,
  });

  factory UserRecord.fromJson(Map<String, dynamic> json) {
    return UserRecord(
      name: json['name'],
      userId: json['userId'],
      userType: json['userType'],
      role: json['role'],
    );
  }

  void setRole(String newRole) {
    role = newRole; // Setter method to update the role
  }
}
