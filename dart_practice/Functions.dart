void addition(var a,{var b,var c}){
  int? sum=a+b;
  print("The sum of $a and $b is: $sum");
}
void subtraction(a,b)=>print("Difference of $a and $b is: ${a-b}");
 
void main(){
  List<int> numList=[1,2,3,4,5];
  int sum=0;
  addition(10,b:20);
  numList.forEach((i)=>
    sum+=i
  );
  print("The sum of the list is: $sum");
  subtraction(10,5);

  
}