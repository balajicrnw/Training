// milk.dart
import 'coffee_decorator.dart';

class Milk extends CoffeeDecorator {
  Milk(super.coffee);

  @override
  String getDescription() => "${coffee.getDescription()} + Milk";

  @override
  double getCost() => coffee.getCost() + 2.0;
}