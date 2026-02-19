import 'dart:io';
extension StringExtension on String{
  String captialize(){
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

void main(){
  String n=stdin.readLineSync()!;
  print(n.captialize());
}
  