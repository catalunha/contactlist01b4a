import 'dart:convert';

class ContactModel {
  static const String className = 'Contact';

  final String id;
  final String name;
  final String? photo;
  ContactModel({
    required this.id,
    required this.name,
    this.photo,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? photo,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': id,
      'name': name,
      'photo': photo,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['objectId'],
      name: map['name'],
      photo: map['photo']?['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactModel(id: $id, name: $name, photo:$photo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel &&
        other.id == id &&
        other.name == name &&
        other.photo == photo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ photo.hashCode;
}
