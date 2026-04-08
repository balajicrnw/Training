import 'memento.dart';

class Caretaker {
  final List<Memento> _history = [];

  void save(Memento memento) {
    _history.add(memento);
  }

  Memento? undo() {
    if (_history.isEmpty) return null;
    return _history.removeLast();
  }

  bool get canUndo => _history.isNotEmpty;
}