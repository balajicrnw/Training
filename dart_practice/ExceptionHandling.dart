class MaxCountExceededException implements Exception {
  String toString() {
    return "Maximum count exceeded.";
  }
}

class Person {
  String name;
  int age;

  Person(this.name, this.age) {
    if(name.length > 10){
      throw MaxCountExceededException();
    }

    else{
      print("Person created: Name: $name, Age: $age");
    }

  }
}

void main(){
 
  try{
    int result=10~/0;
    print(result);
  }
  catch(e){
    print("An error occurred: $e");
  }

  try{
    Person person1 = Person("Balaji", 21);
    Person person2 = Person("adrvbeuaurgvfrftftrfy", 22);
  }
  catch(e){
    print("Error: $e");
  }
  
}