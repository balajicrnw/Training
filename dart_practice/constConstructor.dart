class Student {
  final String name;
  final int age;

  const Student({required this.name, required this.age});
}

void main(){
  const s1=Student(name: "Ganesh", age: 22);
  const s2=Student(name: "Ganesh", age: 22);
  const s3=Student(name: "Balaji", age: 21);
  print(identical(s1, s2)); 
  print(identical(s1, s3));

}