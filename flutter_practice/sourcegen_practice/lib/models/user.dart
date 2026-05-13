import 'package:sourcegen_practice/annotations/auto_hello.dart';
import 'package:sourcegen_practice/annotations/model.dart';

part 'user.g.dart';

// @AutoHello()

@Model()
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});
}
