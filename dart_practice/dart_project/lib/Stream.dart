class numStream{
  Stream<int> CountDown(int start) async* {
    for(int i=start; i>=0;i--){
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}

Future<void> main() async{
  numStream ns=new numStream();
   Stream<int> stream=ns.CountDown(10);
  stream.listen((number) {
    print(number);
  });

  // Stream<int> stream2=ns.CountDown(5);
  // await for(int number in stream2){
  //   print(number);
  // }
}