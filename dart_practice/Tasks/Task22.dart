int recursefact(int n){
  if(n==1){
    return 1;
  }
  else{
    return n*recursefact(n-1);
  }
}
void main(){
  int n=5;
  int result=recursefact(n);
  print("Factorial of $n is $result");
}
