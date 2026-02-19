mixin Fly{
  void fly(){
    print("I can fly");
  }
}

mixin Walk{
  void walk(){
    print("I can walk");
  }
}

class Human with Walk{
  void display(){
    print("I am a human with a good brain");
  }
}

class Bird with Fly,Walk{
  void display(){
    print("I am a bird with wings");
  }
}
void main(){
  Human h=new Human();
  h.display();
  h.walk();
  print("*"*50);
  Bird b=new Bird();
  b.display();
  b.walk();
  b.fly();
}
