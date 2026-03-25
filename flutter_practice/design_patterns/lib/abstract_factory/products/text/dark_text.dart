import 'package:flutter/material.dart';
import 'my_text.dart';

class DarkText implements MyText {
  @override
  Widget build(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.amberAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}
