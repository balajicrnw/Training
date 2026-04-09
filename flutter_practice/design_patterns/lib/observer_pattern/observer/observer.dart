import '../model/calculator_data.dart';

abstract class Observer {
  void update(CalculatorData data);
}