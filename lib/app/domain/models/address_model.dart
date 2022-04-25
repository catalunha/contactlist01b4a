import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AddressModel {
  static const String className = 'Address';
  final String? id;
  ParseObject? _parseObject;
  final String cep;
  final String description;
  final String? city;
  final String? state;
  AddressModel({
    this.id,
    required this.cep,
    required this.description,
    this.city,
    this.state,
  });

  AddressModel copyWith({
    String? id,
    String? cep,
    String? description,
    String? city,
    String? state,
  }) {
    return AddressModel(
      id: id ?? this.id,
      cep: cep ?? this.cep,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cep': cep,
      'description': description,
      'city': city,
      'state': state,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      cep: map['cep'],
      description: map['description'],
      city: map['city'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  factory AddressModel.fromParse(ParseObject parseObject) {
    return AddressModel(
      id: parseObject.objectId,
      cep: parseObject.get('cep'),
      description: parseObject.get('description'),
      city: parseObject.get('city'),
      state: parseObject.get('state'),
    );
  }

  ParseObject toParse() {
    final address = ParseObject('Address');
    if (id != null) address.objectId = id;
    address.set('cep', cep);
    address.set('description', description);
    address.set('city', city);
    address.set('state', state);
    return address;
  }

  @override
  String toString() {
    return 'AddressModel(id: $id, cep: $cep, description: $description, city: $city, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.id == id &&
        other.cep == cep &&
        other.description == description &&
        other.city == city &&
        other.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cep.hashCode ^
        description.hashCode ^
        city.hashCode ^
        state.hashCode;
  }
}
