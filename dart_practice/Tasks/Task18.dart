import 'dart:io';

void tables(int n){
  for(int i=1;i<=10;i++){
    print("$n x $i = ${n*i}");
  }
}
void main(){
  int n=int.parse(stdin.readLineSync()!);
  tables(n);
}