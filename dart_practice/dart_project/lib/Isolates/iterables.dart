void main(){
  final a =show(10);

  print(a.elementAt(5));
  print(a);
}

Iterable<int> show(int n) sync*{
  for (int i=0;i <= n;i++){
    yield i;
  }
}