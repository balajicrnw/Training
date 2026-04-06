// sugar.dart
import 'coffee_decorator.dart';

class Sugar extends CoffeeDecorator {
  Sugar(super.coffee);

  @override
  String getDescription() => "${coffee.getDescription()} + Sugar";

  @override
  double getCost() => coffee.getCost() + 1.0;
}