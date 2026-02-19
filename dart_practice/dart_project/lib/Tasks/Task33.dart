Stream<int> waitTime(int n) async*{
  for(int i=n;i>0;i--){
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main(){
  waitTime(10).listen((event) {
    print(event);
  });
}