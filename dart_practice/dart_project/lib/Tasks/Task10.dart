void main(){
  List<Map<String,dynamic>> students=[];
  students.add({"id":1,"name": "batman"});
  students.add({"id":2,"name": "Superman"});
  students.add({"id":3,"name": "Wonder Woman"});

  students[0]["name"]="Batman";

  students.forEach((student)=>print("Name: ${student["name"]}"));
}