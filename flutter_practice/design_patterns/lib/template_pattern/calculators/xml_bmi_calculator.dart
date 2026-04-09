import '../models/student.dart';
import '../calculators/bmi_calculator.dart';
import '../data_sources/xml_api.dart';

class XmlBmiCalculator extends BmiCalculator {
  final api = XmlApi();

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