class Student{
  String? name;
  int? age;

  Student(this.name,this.age);
}

void main(){
  Student s1=Student("Balaji",21);
  Student s2=Student("Chukka",22);
  print(s1.name);
  print(s1.age);
  print(s2.name);
  print(s2.age);
}