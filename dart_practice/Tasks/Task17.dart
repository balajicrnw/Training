import 'dart:io';

void primeCheck(int n){
  bool isPrime=true;
  if(n<=1){
    isPrime=false;
  }
  else{
    for(int i=2;i<=(n/2);i++){
      if(n%i==0){
        isPrime=false;
        break;
      }
    }
  }
  if(isPrime){
    print("$n is a prime number");
  }
  else{
    print("$n is not a prime number");
  }

}
void main(){
  int n=int.parse(stdin.readLineSync()!);
  primeCheck(n);
}