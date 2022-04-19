import 'dart:convert';

class UserModel {
  static const String className = '_User';

  final String objectId;
  final String email;
  final String username;
  final String sessionToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  UserModel({
    required this.objectId,
    required this.email,
    required this.username,
    this.createdAt,
    this.updatedAt,
    required this.sessionToken,
  });

  UserModel copyWith({
    String? objectId,
    String? email,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sessionToken,
  }) {
    return UserModel(
      objectId: objectId ?? this.objectId,
      email: email ?? this.email,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sessionToken: sessionToken ?? this.sessionToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': objectId,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sessionToken': sessionToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      objectId: map['objectId'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString())
          : null,
      sessionToken: map['sessionToken'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));
  String toJson() {
    var map = toMap();
    map['createdAt'] = createdAt?.toIso8601String();
    map['updatedAt'] = updatedAt?.toIso8601String();
    return json.encode(map);
  }

  factory UserModel.fromJson(String source) {
    var map = json.decode(source);
    map['createdAt'] =
        map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null;
    map['updatedAt'] =
        map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt']) : null;
    return UserModel.fromMap(map);
  }
  @override
  String toString() {
    return 'UserModel(objectId: $objectId, email: $email, username: $username, createdAt: $createdAt, updatedAt: $updatedAt, sessionToken: $sessionToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.objectId == objectId &&
        other.email == email &&
        other.username == username &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.sessionToken == sessionToken;
  }

  @override
  int get hashCode {
    return objectId.hashCode ^
        email.hashCode ^
        username.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        sessionToken.hashCode;
  }
}
