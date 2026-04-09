import 'observer.dart';
import '../model/calculator_data.dart';

class Addition implements Observer {
  double result = 0;

  @override
  void update(CalculatorData data) {
    result = data.a + data.b;
  }
}