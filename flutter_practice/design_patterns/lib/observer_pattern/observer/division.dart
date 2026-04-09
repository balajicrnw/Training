import 'package:design_patterns/observer_pattern/model/calculator_data.dart';
import 'package:design_patterns/observer_pattern/observer/observer.dart';

class Division implements Observer {
  double result = 0;

  @override
  void update(CalculatorData data) {
    result = data.b != 0 ? data.a / data.b : 0;
  }
}