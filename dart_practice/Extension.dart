extension StringExtension on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension intExtension on int{
  bool isEvenNumber(){
    return this%2==0;
  }
  bool isOddNumber(){
    return this%2!=0;
  }
}

extension ListExtension on List{
  void printList(){
    for(var element in this){
      print(element);
    }
  }
}
void main(){
  String name="balaji";
  print(name.capitalize());
  int num=10;
  List<int> list=[1,2,3,4,5];
  print(num.isEvenNumber());
  print(num.isOddNumber());
  list.printList();

}     