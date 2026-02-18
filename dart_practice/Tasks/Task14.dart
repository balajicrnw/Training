import 'dart:io';

void main(){
  print("Just enter value from 1 to 5");
  

  try{
    int a=int.parse(stdin.readLineSync()!);
    switch(a){
      case 1:
        print("One");
        break;
      case 2:
        print("Two");
        break;
      case 3:
        print("Three");
        break;  
      case 4:
        print("Four");
        break;           
        case 5:
        print("Five");
        break;
      default:
        print("more than 5");
    }
  }
  catch(e){
    print("not a number");
  }
  

}