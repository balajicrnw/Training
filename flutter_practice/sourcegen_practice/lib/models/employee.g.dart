// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// AutoModelGenerator
// **************************************************************************

class _Employee {
  final String name;
  final int age;
  final double salary;
  _Employee({required this.name, required this.age, required this.salary});

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'salary': salary};
  }

  factory _Employee.fromJson(Map<String, dynamic> json) {
    return _Employee(
      name: json['name'],
      age: json['age'],
      salary: json['salary'],
    );
  }
}
