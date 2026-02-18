void main(){
  // int a=null; // error because int is non nullable
  int? a=null; // this is nullable int

  String? b=null; // error because string is non nullable
  b="value is not null" ?? "value is null";
  
  int? c=null;
  
  c??=100;   // if a is null then assign 100 to a else assign 0 to a
  // c=null;
  print(c!); // this is null assertion operator, it tells the compiler that c will not be null at this point
}