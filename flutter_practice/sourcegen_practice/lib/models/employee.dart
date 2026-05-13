import 'package:sourcegen_practice/annotations/auto_model.dart';

part 'employee.g.dart';

@AutoModel(["String name", "int age", "double salary"])
class Employee {}
