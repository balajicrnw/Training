import 'dart:io';

void main(){
  print("Enter your name: ");
  String name=stdin.readLineSync()!;
  print("Enter your age: "); 
  int age=int.parse(stdin.readLineSync()!);
  print("Enter your height in ft: ");
  double heightinft=double.parse(stdin.readLineSync()!);
  print("Are you a human? (true/false): ");
  bool isHuman=stdin.readLineSync()!.toLowerCase() == "true";
  print("My name is, $name");
  print("My age is, $age");
  print("My height is, $heightinft");
  print("I am a human: $isHuman");
  
}