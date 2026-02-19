enum Gender{
  male,
  female,
  other
}
class PersonModel{
  static List<Map<String,dynamic>> jsonData=[{
    'name':'Ganesh',
    'age':22,
    'gender':'male'
  },{
    'name':'Balaji',
    'age':21,
    'gender':'male'
  },
  {
    'name':'DineshUncle',
    'age':30,
    'gender':'male'
  },
  {
    'name':'Sneha',
    'age':30,
    'gender':'female'
  }
  ];
  String name;
  int age;
  Gender gender;
  PersonModel({required this.name, required this.age,required this.gender});
  factory PersonModel.fromJson(Map<String,dynamic> json){
    return PersonModel(
      name: json['name'],
      age: json['age'],
      gender: Gender.values.byName(json['gender'])
    );
  }
  Map<String,dynamic> toJson(){
    return{
      'name':name,
      'age':age,
      'gender':gender
    };
  }
  

  void display(PersonModel person){
    print("Name: ${person.name}");
    print("Age: ${person.age}");
    print("Gender: ${person.gender}");
    print("*"*20);
  }

  static void addPerson(List<PersonModel> list, String name, int age, Gender gender) {
  PersonModel newPerson = PersonModel(name: name, age: age, gender: gender);
  list.add(newPerson);
  jsonData.add(newPerson.toJson());

}
    

  }

void main(){
  List<PersonModel> personList=PersonModel.jsonData.map((json) => PersonModel.fromJson(json)).toList();
  personList.forEach((person) => person.display(person));

  PersonModel.addPerson(personList, "Ramesh", 30, Gender.male);
  personList.forEach((person) => person.display(person));

  print(PersonModel.jsonData);
}