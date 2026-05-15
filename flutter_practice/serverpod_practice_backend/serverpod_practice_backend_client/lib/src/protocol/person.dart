/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Person implements _i1.SerializableModel {
  Person._({
    this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.favoriteColor,
    required this.profession,
  });

  factory Person({
    int? id,
    required String name,
    required int age,
    required String city,
    required String favoriteColor,
    required String profession,
  }) = _PersonImpl;

  factory Person.fromJson(Map<String, dynamic> jsonSerialization) {
    return Person(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      age: jsonSerialization['age'] as int,
      city: jsonSerialization['city'] as String,
      favoriteColor: jsonSerialization['favoriteColor'] as String,
      profession: jsonSerialization['profession'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int age;

  String city;

  String favoriteColor;

  String profession;

  /// Returns a shallow copy of this [Person]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Person copyWith({
    int? id,
    String? name,
    int? age,
    String? city,
    String? favoriteColor,
    String? profession,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Person',
      if (id != null) 'id': id,
      'name': name,
      'age': age,
      'city': city,
      'favoriteColor': favoriteColor,
      'profession': profession,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PersonImpl extends Person {
  _PersonImpl({
    int? id,
    required String name,
    required int age,
    required String city,
    required String favoriteColor,
    required String profession,
  }) : super._(
         id: id,
         name: name,
         age: age,
         city: city,
         favoriteColor: favoriteColor,
         profession: profession,
       );

  /// Returns a shallow copy of this [Person]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Person copyWith({
    Object? id = _Undefined,
    String? name,
    int? age,
    String? city,
    String? favoriteColor,
    String? profession,
  }) {
    return Person(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      favoriteColor: favoriteColor ?? this.favoriteColor,
      profession: profession ?? this.profession,
    );
  }
}
