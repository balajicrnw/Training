import 'dart:io';

void add(int a,int b){
  print("Addition: ${a+b}");

}
void spilt(String input){
  List<String> parts=input.split(",");
  add(int.parse(parts[0].trim()),int.parse(parts[1].trim()));
}
void main(){
  dynamic input=stdin.readLineSync()!;
  spilt(input);
}