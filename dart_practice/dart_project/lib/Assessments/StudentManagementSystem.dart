class Student{
  int id;
  String name;
  int age;

  Student(this.id,this.name,this.age);

  @override
  String toString(){
    return "ID: $id, Name: $name, Age: $age";
  }
}

class Studentmanagementsystem {
  List<Student> students = [];

  void addStudent(Student student) {
    students.add(student);
  }

  void removeStudent(int id) {
    if (students.any((student) => student.id == id)){
      students.removeWhere((student) => student.id == id);
    }
    else{
      print("Student not found");
    }
    
  }

  List<Student> searchStudent(String name) {
    return (students.where((student)=>student.name==name)).toList();
  }

  void showAll(){
    students.forEach((i)=>print(i));
  }
}

void main() {
  Studentmanagementsystem sms = Studentmanagementsystem();

  Student s1 = Student(1, "Balaji", 21);
  Student s2 = Student(2, "Chukka", 22);
  Student s3 = Student(3, "Ganesh",22);
  sms.addStudent(s1);
  sms.addStudent(s2);
  sms.addStudent(s3);
  sms.showAll();

  print(sms.searchStudent("Balaji"));
  sms.removeStudent(90);
  sms.removeStudent(2);
  sms.showAll();
}