abstract class Shape{
  void draw();
  factory Shape(String shape){
    switch(shape){
      case "circle":
        return circle();
      case "square":
        return square();
      case "triangle":
        return triangle();
      default:
        throw ArgumentError("Invalid shape: $shape");
    }
  }
}
class circle implements Shape{
  void draw(){
    print("Drawing a circle");
  } 
}
class square implements Shape{
  void draw(){
    print("Drawing a square");
  }
}
class triangle implements Shape{
  void draw(){
    print("Drawing a triangle");
  }
}

void main(){
  Shape circle=Shape("circle");
  circle.draw();
  Shape square=Shape("square");
  square.draw();
  Shape triangle=Shape("triangle");
  triangle.draw();
  Shape invalid=Shape("aefkjseg");
  invalid.draw();

  
}