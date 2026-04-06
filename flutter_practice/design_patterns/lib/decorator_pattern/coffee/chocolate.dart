// chocolate.dart
import 'coffee_decorator.dart';

class Chocolate extends CoffeeDecorator {
  Chocolate(super.coffee);

  @override
  String getDescription() => "${coffee.getDescription()} + Chocolate";

  @override
  double getCost() => coffee.getCost() + 3.0;
}