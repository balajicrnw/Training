void main(){
  int age=22;
  String name="Balaji";
  bool isHuman=true;
  double height=5.7;

  List<String> hobbies=["Coding","Gaming","Cooking"]; //ordered collection of items
  Set<String> uniqueHobbies={"Coding","Gaming","Cooking","Coding"}; //unordered

  Map<String,dynamic> person={};  //keyvalue pairs
  person['name']="Balaji";
  person['age']=21;
  person['isHuman']=true;
  person['height']=height;

  print(person);

}