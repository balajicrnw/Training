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
    print("Prime");
  }
  else{
    print("not Prime");
  }

}
void main(){
  int n=int.parse(stdin.readLineSync()!);
  primeCheck(n);
}