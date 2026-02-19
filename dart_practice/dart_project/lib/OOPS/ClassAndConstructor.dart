class Student{
  final int id;
  final String name;

  Student(this.id,this.name);

  const Student.guest():
    id=0,
    name="Guest";         //initializer list is used to initialize final variables in a const constructor
}
void main(){
  Student s1=Student(1,"Balaji");
  Student s2=Student(2,"Ganesh");
  const s3=Student.guest();
  print("id: ${s1.id}, name: ${s1.name}");
  print("id: ${s2.id}, name: ${s2.name}");
  print("id: ${s3.id}, name: ${s3.name}");
}