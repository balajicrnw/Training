class Box<T>{
  T content;
  Box(this.content);
}

void main(){
  Box intBox = Box<int>(123);
  Box stringBox = Box<String>("Hello");
  Box doubleBox = Box<double>(123.23423);
  
  print(intBox.content); 
  print(stringBox.content);
  print(doubleBox.content);

}