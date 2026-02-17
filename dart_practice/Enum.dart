import 'dart:io';

enum days{
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

void main(){
  days today=days.monday;
  print (today);
  print(days.values);
  print(today.name);
  print(today.index);
  
  int a=int.parse(stdin.readLineSync()!);
  
  switch(a){
    case 1:
      print(days.monday);
      break;
    case 2:
      print(days.tuesday);
      break;
    case 3:
      print(days.wednesday);
      break;
    case 4:
      print(days.thursday);
      break;
    case 5:
      print(days.friday);
      break;
    case 6:
      print(days.saturday);
      break;
    case 7:
      print(days.sunday);
      break;
    default:
      print("Invalid Input");
      break;
  
  }
}