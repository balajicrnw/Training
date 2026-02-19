void main(){
  List<int> numbers=[1,2,3,4,5];
  numbers.add(6);
  print(numbers);
  numbers.remove(3);   //value
  print(numbers);
  numbers.removeAt(3);  //index
  print(numbers);
  print(numbers.length);
}