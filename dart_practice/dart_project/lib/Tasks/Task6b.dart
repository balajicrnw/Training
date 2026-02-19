import 'dart:io';
void main(){
  String a=stdin.readLineSync()!;
  String b=a.replaceAll(" ", "");
  print(b);
}