void main(){
  int? a=null;
  if(a==null){
    a=100;
  }
  else{
    print("a is not null");
  }

  int money=1000;

  if(money>600){
    print("you can buy wireless earphones  ");
  }
  else if(money<600){
    print("you can buy wired earphones");
  }
  else if(money<0){
    print("Kassu illa bro");
  }
  else{
    print("pocket kuda illa bro");
  }

  String order="Chicken Briyani";

  switch(order){
    case "Chicken Briyani":
      print("You ordered Chicken Briyani");
      break;
    case "Mutton Briyani":
      print("You ordered Mutton Briyani");
      break;
    default:
      print("Kadaila illa bro only Chiken and Mutton Briyani available");
  }



}