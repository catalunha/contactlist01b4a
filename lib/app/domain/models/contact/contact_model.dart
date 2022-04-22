import 'dart:convert';

class ContactModel {
  static const String className = 'Contact';

  final String id;
  final String name;
  final String? photo;
  final DateTime? birthday;
  ContactModel({
    required this.id,
    required this.name,
    this.photo,
    this.birthday,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? photo,
    DateTime? birthday,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': id,
      'name': name,
      'photo': photo,
      'birthday': birthday,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['objectId'],
      name: map['name'],
      photo: map['photo']?['url'],
      birthday: map['birthday'],
    );
  }

  String toJson() {
    var map = toMap();
    map['birthday'] = birthday?.toIso8601String();
    return json.encode(map);
  }

  factory ContactModel.fromJson(String source) {
    var map = json.decode(source);
    map['birthday'] = map['birthday']?['iso'] != null
        ? DateTime.tryParse(map['birthday']?['iso'])
        : null;
    return ContactModel.fromMap(map);
  }

  @override
  String toString() =>
      'ContactModel(id: $id, name: $name, photo:$photo, birthday:$birthday)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel &&
        other.id == id &&
        other.name == name &&
        other.photo == photo &&
        other.birthday == birthday;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ photo.hashCode ^ birthday.hashCode;
}
