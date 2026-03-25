import 'package:flutter/material.dart';
import 'my_text.dart';

class LightText implements MyText {
  @override
  Widget build(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
