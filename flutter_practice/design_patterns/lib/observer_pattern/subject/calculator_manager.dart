import '../observer/observer.dart';
import '../model/calculator_data.dart';

class CalculatorManager {
  final List<Observer> _observers = [];

  void subscribe(Observer obs) {
    _observers.add(obs);
  }

  void notify(CalculatorData data) {
    for (var obs in _observers) {
      obs.update(data);
    }
  }
}