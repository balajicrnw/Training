import 'dart:io';

void maxnum(int a,int b,int c){
  int max=a;
  if(b>max){
    max=b;
  }
  if(c>max){
    max=c;
  }
  print(max);
}
void main(){
  String input=stdin.readLineSync()!;
  List<String> parts=input.split(",");
  int a=int.parse(parts[0].trim());
  int b=int.parse(parts[1].trim());
  int c=int.parse(parts[2].trim());
  maxnum(a,b,c);
}