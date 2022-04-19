import 'dart:convert';

class UserModel {
  static const String collection = 'User';

  final String objectId;
  final String email;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  UserModel({
    required this.objectId,
    required this.email,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? objectId,
    String? email,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      objectId: objectId ?? this.objectId,
      email: email ?? this.email,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': objectId,
      'email': email,
      'username': username,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      objectId: map['objectId'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(objectId: $objectId, email: $email, username: $username, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.objectId == objectId &&
        other.email == email &&
        other.username == username &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        email.hashCode ^
        username.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
