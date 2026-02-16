void main(){
  List<int> numList=[1,2,3,4,5,6,7,8,9,10];
  int sum=0;
  List<int> evenList=numList.where((i)=>i%2==0).toList();
  List<int> oddList=numList.where((i)=>i%2!=0).toList();
  List<int> Multipleof2=numList.map((i)=>i*2).toList();
  numList.forEach((i)=>sum+=i);
  print("Sum of all numbers in the list is: $sum")
  ;
  print(evenList);
  print(oddList);
  print(Multipleof2);


}