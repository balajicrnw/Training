import 'dart:ui';

import '../model/canvas_state.dart';
import 'memento.dart';

class Originator {
  CanvasState state;

  Originator()
      : state = CanvasState(
          color: const Color(0xFF000000),
          size: 50,
        );

  Memento save() {
    return Memento(state);
  }

  void restore(Memento memento) {
    state = memento.state;
  }
}