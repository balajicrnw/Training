void main(){
  List<int> numbers=[10,20,40,50,60,70,90,100];
  numbers.removeWhere((i)=>i>50);
  print(numbers);
  
}