import 'dart:io';
void main(){
  String a=stdin.readLineSync()!;
  String b="";
  for(int i=0;i<a.length;i++){
    if(a[i]==" "){
      continue;
    }
    b+=a[i];
  }
  print(b);
}