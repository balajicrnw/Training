// coffee_decorator.dart
import 'coffee.dart';

abstract class CoffeeDecorator implements Coffee {
  final Coffee coffee;

  CoffeeDecorator(this.coffee);

  @override
  String getDescription() => coffee.getDescription();

  @override
  double getCost() => coffee.getCost();
}