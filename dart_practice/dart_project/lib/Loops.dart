import 'dart:io';

void main(){
  for(int i=0;i<5;i++){
    print(i);
  }
  int a=100;
  int? guess=0;
  
  List<String> names=["Dinesh","Balaji","Chukka","Ganesh"];
  for (String name in names){
    print(name);
    if (name=="Chukka"){
      break; 
    }
  }

  for (String name in names){
    if (name=="Chukka"){
      continue; 
    }
    print(name);
  }



  while(guess!=a){
    print("Enter your guess:");
    guess=int.parse(stdin.readLineSync()!);
    if(guess<a){
      print("Too low! Try again.");
    }
    else if(guess>a){
      print("Too high! Try again.");
    }
    else{
      print("Congratulations! You guessed the number.");
    }

  }

}