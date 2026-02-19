void main(){
  List<int> numbers=[10,20,40,50,60,70,90,100];
  numbers=numbers.where((i)=>i<=50).toList();
  print(numbers);
  
}