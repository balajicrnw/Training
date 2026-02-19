void main(){
  // Basic arithmetic operators
  dynamic a=100;
  int c=9;
  int b=200;

  print(a+b);
  print(a-b);
  print(a*b);
  print(a/b);
  print(a%b);

  print(a~/c); // gives the divison value without decimal part
  print(a);

  print(c++);
  print(c);
  print(++c);
  
  // basic assignment operators
  a+=10; 
  print(a);
  a-=10; 
  print(a);
  a*=10; 
  print(a);
  a/=10; 
  print(a);
  a%=10; 
  print(a);
  a~/=10; 
  print(a);
  a=null;

  a??=100;  // if a value is null then only assign 100 to a
  print(a);

  // comparism operators
  print(a==100);
  print(a!=100);
  print(a>100);
  print(a<100);
  print(a>=100);
  print(a<=100);

  print(a is int);
  print(a is! int);
  print(a is String);

  dynamic name="Balaji";
  String s=name as String; // type casting
  print(s);

  if(a==100 && name=="Balaji"){
    print("Both conditions are true");
  }

  if (a==100 || name=="Balaji"){
    print("At least one condition is true");
  }

  if(!(a==100)){
    print("a is not equal to 100");
  }

}