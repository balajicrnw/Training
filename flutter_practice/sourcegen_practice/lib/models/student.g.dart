// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// AutoModelGenerator
// **************************************************************************

class _Student {
  final String name;
  final int age;
  final double height;
  _Student({required this.name, required this.age, required this.height});

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'height': height};
  }

  factory _Student.fromJson(Map<String, dynamic> json) {
    return _Student(
      name: json['name'],
      age: json['age'],
      height: json['height'],
    );
  }
}
