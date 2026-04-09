import '../models/student.dart';

abstract class BmiCalculator {

  List<Student> calculate() {
    var students = getStudents();     
    students = filter(students);      
    _calculateBmi(students);          
    return students;
  }

  List<Student> getStudents();


  List<Student> filter(List<Student> students) {
    return students;
  }


  void _calculateBmi(List<Student> students) {
    for (var s in students) {
      s.bmi = s.weight / (s.height * s.height);
    }
  }
}