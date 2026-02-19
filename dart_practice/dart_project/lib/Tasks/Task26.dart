import 'dart:io';

abstract class Shape{
  int? length;
  int? breadth;
  int? base;
  int? sides;
  int? radius;
  int? height;
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
  Triangle(int base,int height){
    this.base=base;
    this.height=height;
  }
  @override
  void area() =>print("Area of Triangle: ${0.5 * base! * height!}");
  
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
  while(true){
    print("What you need to find the area of: ");
    print("1. Rectangle");
    print("2. Triangle");
    print("3. Square");
    print("4. Circle");
    print("5. Exit");
    int choice=int.parse(stdin.readLineSync()!);
    switch(choice){
      case 1:
        print("Enter length and breadth of Rectangle: ");
        int l=int.parse(stdin.readLineSync()!);
        int b=int.parse(stdin.readLineSync()!);
        Rectangle r=Rectangle(l, b);
        r.area();
        break; 
      case 2:
        print("Enter base of Triangle: ");
        int b=int.parse(stdin.readLineSync()!);
        int h=int.parse(stdin.readLineSync()!);
        Triangle t=Triangle(b,h);
        t.area();
        break;
      case 3:
        print("Enter sides of Square: ");
        int s=int.parse(stdin.readLineSync()!);
        square sq=square(s);
        sq.area();
        break;
      case 4:
        print("Enter radius of Circle: ");
        int r=int.parse(stdin.readLineSync()!);
        Circle c=Circle(r);
        c.area();
        break;
      case 5:
        exit(0);
      default:
        print("Invalid choice");
    
  }

  }
}