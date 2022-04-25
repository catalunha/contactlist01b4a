import 'dart:convert';

import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ContactModel {
  static const String className = 'Contact';

  final String? id;
  final String name;
  final String? photo;
  final DateTime? birthday;
  final AddressModel? address;
  ContactModel({
    required this.id,
    required this.name,
    this.photo,
    this.birthday,
    this.address,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? photo,
    DateTime? birthday,
    AddressModel? address,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': id,
      'name': name,
      'photo': photo,
      'birthday': birthday,
      'address': address?.toMap(),
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['objectId'],
      name: map['name'],
      photo: map['photo']?['url'],
      birthday: map['birthday'],
      address: AddressModel.fromMap(map['address']),
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

  factory ContactModel.fromParse(ParseObject parseObject) {
    return ContactModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      photo: parseObject.get('photo')?.get('url'),
      birthday: parseObject.get('birthday'),
      address: parseObject.get('address') != null
          ? AddressModel.fromParse(parseObject.get('address'))
          : null,
    );
  }

  // ParseObject toParse() {
  //   final contact = ParseObject('Contact');
  //   if (id != null) contact.objectId = id;
  //   contact.set('name', name);
  //   contact.set('description', description);
  //   contact.set('city', city);
  //   contact.set('state', state);
  //   return contact;
  // }

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
