class Box<T>{
  T value;
  Box(this.value);

  void storedValue(){
    print(value);
  }
}

void main(){
  Box b1=Box("Balaji");
  Box b2=Box(21);

  Box b3=Box({"name":"Balaji","age":21});
  b1.storedValue();
  b2.storedValue();
  b3.storedValue();
}
