class PersonModel{
  String name;
  int age;

  PersonModel({required this.age,required this.name});

  Map<String,dynamic> toMap(){
    return({
    "name":name,
    "age":age
  });
  }

  factory PersonModel.fromMap(Map<String,dynamic> map){
    return(PersonModel(
      name:map['name'],
      age:map['age']      
    ));
    
  }
}

void main(){
  Map<String,dynamic> PersonDetails;
  PersonModel s1=PersonModel(age: 21, name: "Balaji");
  PersonDetails=s1.toMap();
  print(PersonDetails["name"]);
}
