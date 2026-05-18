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

abstract class UserModelDb implements _i1.SerializableModel {
  UserModelDb._({
    this.id,
    required this.userId,
    required this.email,
    this.name,
    this.gender,
    this.profileImageUrl,
    this.createdAt,
  });

  factory UserModelDb({
    int? id,
    required String userId,
    required String email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  }) = _UserModelDbImpl;

  factory UserModelDb.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserModelDb(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String?,
      gender: jsonSerialization['gender'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String email;

  String? name;

  String? gender;

  String? profileImageUrl;

  DateTime? createdAt;

  /// Returns a shallow copy of this [UserModelDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserModelDb copyWith({
    int? id,
    String? userId,
    String? email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserModelDb',
      if (id != null) 'id': id,
      'userId': userId,
      'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserModelDbImpl extends UserModelDb {
  _UserModelDbImpl({
    int? id,
    required String userId,
    required String email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         email: email,
         name: name,
         gender: gender,
         profileImageUrl: profileImageUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserModelDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserModelDb copyWith({
    Object? id = _Undefined,
    String? userId,
    String? email,
    Object? name = _Undefined,
    Object? gender = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? createdAt = _Undefined,
  }) {
    return UserModelDb(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name is String? ? name : this.name,
      gender: gender is String? ? gender : this.gender,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
