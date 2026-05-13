// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age};
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], age: json['age']);
  }
}
