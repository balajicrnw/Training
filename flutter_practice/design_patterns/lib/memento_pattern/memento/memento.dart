import '../model/canvas_state.dart';

class Memento {
  final CanvasState state;

  Memento(CanvasState state) : state = CanvasState.copy(state);
}