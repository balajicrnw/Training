import 'json_bmi_calculator.dart';
import '../models/student.dart';

class TeenBmiCalculator extends JsonBmiCalculator {

  @override
  List<Student> filter(List<Student> students) {
    return students.where((s) => s.age < 20).toList();
  }
}