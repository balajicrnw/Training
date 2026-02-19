Future<void> timeWait(n) async{
  for(int i=n;i>0;i--){
    await Future.delayed(Duration(seconds: 1));
    print(i);
  }
}
void main() async{
  await timeWait(10);
  print("Data recieved");
}