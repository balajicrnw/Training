import 'package:flutter/material.dart';

class CanvasState {
  Color color;
  double size;

  CanvasState({
    required this.color,
    required this.size,
  });

  CanvasState.copy(CanvasState state)
      : color = state.color,
        size = state.size;
}