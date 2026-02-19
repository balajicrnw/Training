class add{
  int call(int a,int b){
    return a+b;
  }
}
class prints{
  void call(String name){
    print("Hello this is a test $name");
  }
}
void main(){
  add addition=add();
  int result=addition(5,10);
  print("The sum of 5 and 10 is: $result");
  prints p=prints();
  p("Balaji");
}