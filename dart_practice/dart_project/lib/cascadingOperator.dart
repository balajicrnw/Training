class Example{
  int? age;
  String? name;

  Example({this.age, this.name});

  void welcome(){
    print("Welcome");
  }
  void details(){
    print("Name: $name, Age: $age");
  }
}

void main(){
  Example ex=new Example()..age=10..name="Balaji"..welcome()..details();
  ex..age=21..name="chukka"..welcome()..details();
}
