import 'package:sourcegen_practice/annotations/auto_model.dart';

part 'student.g.dart';

@AutoModel(["String name", "int age", "double height"])
class Student {}
