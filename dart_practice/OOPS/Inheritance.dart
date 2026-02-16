class Person{
  String? name;
  int? age;

  Person(this.name,this.age);

  void display(){
    print("Name: $name");
    print("Age: $age");
  }
  void linespace(int n){
    print("-"*n);
  }
}

class Employee extends Person{
  String? company;
  String? empid;

  Employee(String name, int age, this.company,this.empid) : super(name, age);

  void displayEmployee(){
    display();
    print("Company: $company");
    print("Empid: $empid");
  }
}

class Manager extends Employee{
  String? department;

  Manager(String name, int age, String company, String empid, this.department) : super(name, age, company, empid);

  void displayManager(){
    displayEmployee();
    print("Department: $department");
  }
}


void main(){
  Person p=new Person("Ganesh",22);
  p.display();
  p.linespace(20);
  Employee e=new Employee("Balaji",21,"NativeWit","emp23");
  e.displayEmployee();
  e.linespace(20);
  Manager m=new Manager("Ramesh",30,"NativeWit","emp24","IT");
  m.displayManager();
}