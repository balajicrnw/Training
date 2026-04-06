// simple_coffee.dart
import 'coffee.dart';

class SimpleCoffee implements Coffee {
  @override
  String getDescription() => "Simple Coffee";

  @override
  double getCost() => 5.0;
}