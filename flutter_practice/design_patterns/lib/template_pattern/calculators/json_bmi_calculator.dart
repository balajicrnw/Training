import '../models/student.dart';
import '../calculators/bmi_calculator.dart';
import '../data_sources/json_api.dart';

class JsonBmiCalculator extends BmiCalculator {
  final api = JsonApi();

  @override
  List<Student> getStudents() {
    return api.fetch().map((e) => Student(
      name: e['name'],
      age: e['age'],
      height: e['height'],
      weight: e['weight'],
    )).toList();
  }
}