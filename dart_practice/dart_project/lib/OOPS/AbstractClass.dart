abstract class Vehicle{
  String? color;
  String? rgbCode;
  double? fuelCapacity;
  double? mileage;
  int? seats;
  int? wheels;
  String? model;
  bool? rearcamera;

  void displayVehicle();
}

class Car extends Vehicle{
  Car(String color, String rgbCode, double fuelCapacity, double mileage, int seats, int wheels, String model, bool rearcamera){
    this.color=color;
    this.rgbCode=rgbCode;
    this.fuelCapacity=fuelCapacity;
    this.mileage=mileage;
    this.seats=seats;
    this.wheels=wheels;
    this.model=model;
    this.rearcamera=rearcamera;
  }
  @override
  void displayVehicle(){
    print("Color: $color");
    print("RGB Code: $rgbCode");
    print("Fuel Capacity: $fuelCapacity");
    print("Mileage: $mileage");
    print("Seats: $seats");
    print("Wheels: $wheels");
    print("Model: $model");
    print("Rear Camera: $rearcamera");
  }
}

class Bike extends Vehicle{
  Bike(String color, String rgbCode, double fuelCapacity, double mileage, int seats, int wheels, String model){
    this.color=color;
    this.rgbCode=rgbCode;
    this.fuelCapacity=fuelCapacity;
    this.mileage=mileage;
    this.seats=seats;
    this.wheels=wheels;
    this.model=model;
  }
  @override
  void displayVehicle(){
    print("Color: $color");
    print("RGB Code: $rgbCode");
    print("Fuel Capacity: $fuelCapacity");
    print("Mileage: $mileage");
    print("Seats: $seats");
    print("Wheels: $wheels");
    print("Model: $model");
  
  }
}

void main(){
  Car c=new Car("Red", "#FF0000", 50.0, 15.0, 5, 4, "BMW X5", true);
  c.displayVehicle();
  print("\n");
  Bike b=new Bike("Blue", "#0000FF", 15.0, 30.0, 2, 2, "Royale enfield Hunter 350");
  b.displayVehicle();
}