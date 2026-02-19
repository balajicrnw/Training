abstract class Shape{
  int? length;
  int? breadth;
  int? base;
  int? sides;
  int? radius;
  void area();
}

class Rectangle extends Shape{
  Rectangle(int length, int breadth){
    this.length=length;
    this.breadth=breadth;
  }
  @override
  void area() =>print("Area of Rectangle: ${length! * breadth!}");

}

class Triangle extends Shape{
  Triangle(int base){
    this.base=base;
  }
  @override
  void area() =>print("Area of Triangle: ${0.5 * base! * base!}");
  
}

class square extends Shape{
  square(int sides){
    this.sides=sides;
  }
  @override
  void area() =>print("Area of Square: ${sides! * sides!}");

}

class Circle extends Shape{
  Circle(int radius){
    this.radius=radius;
  }
  @override
  void area() =>print("Area of Circle: ${3.14 * radius! * radius!}");
  
}
void main(){
  Rectangle r=new Rectangle(5, 10);
  r.area();
  Triangle t=new Triangle(5);
  t.area();
  square s=new square(5);
  s.area();
  Circle c=new Circle(5);
  c.area();

}