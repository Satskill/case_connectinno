class UserModel {
  final String id;
  final String email;
  final String fullName;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }
}
