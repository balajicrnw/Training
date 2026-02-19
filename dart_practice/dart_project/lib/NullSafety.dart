void printDetails({required String? name,required int? age, String? city}){
  print("Name: ${name!}");
  print("Age: $age");
  print("City: ${city ?? "City not provided"}");
}
void main(){
  int? age=21;
  late String? name;
  String? city; 
  //printDetails(name, age); i give late which means i need to assign value before using it
  name="Balaji";
  printDetails(name: name, age: age, city: city);
}