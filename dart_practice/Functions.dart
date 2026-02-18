void addition(var a,{var b,var c=0}){
  int? sum=a+b+c;
  if(c==0){
    print("The sum of $a and $b is: $sum");
  }
  else
  print("The sum of $a and $b and $c is: $sum");
}

  
void subtraction(a,b)=>print("Difference of $a and $b is: ${a-b}");
 
void main(){
  List<int> numList=[1,2,3,4,5];
  int sum=0;
  addition(10,b:20);
  addition(10,b:20,c:30);
  numList.forEach((i)=>
    sum+=i
  );

  print("The sum of the list is: $sum");
  subtraction(10,5);
  (()=>print("This is an anonymous function"))();
}