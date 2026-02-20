class Student{
  int id;
  String name;
  int age;
  double heightinft;
  List<String> subjects;
  Map<String,dynamic>? StudentDetails;
  int updateCount=0;

  Student(this.id,this.name,this.age,this.heightinft,this.subjects){
    this.StudentDetails={
      "id":id,
      "name":name,
      "age":age,
      "heightinft":heightinft,
      "subjects":subjects
    };
  }

  

  updateDetails(String key,dynamic value){
    this.StudentDetails![key]=value;
    updateCount++;
  }

}

extension StudentExtension on Student{
  printDetails(){
    print("id: ${StudentDetails!['id']}");
    print("name: ${StudentDetails!['name']}");
    print("age: ${StudentDetails!['age']}");
    print("heightinft: ${StudentDetails!['heightinft']}");
    print("subjects: ${StudentDetails!['subjects']}");
  }
}

  void main(){
    List<String> subjects=[];
    subjects.addAll(["Maths","Physics","Chemistry","Biology"]);
    Student s1=new Student(1,"Balaji",21,5.8,subjects);
    s1.printDetails();
    subjects.remove( "Biology");
    subjects.add("Computer Science");
    Student s2=new Student(2,"Ganesh",22,5.9,subjects);
    s2.printDetails();
    s1.updateDetails("subjects", subjects);
    s1.updateDetails("age", 22);
    s1.printDetails();
    s2.updateDetails("heightinft", 6.0);
    s2.printDetails();
    print("Update count for s1: ${s1.updateCount}");
    print("Update count for s2: ${s2.updateCount}");
}
