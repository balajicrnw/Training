import 'package:flutter/material.dart';

abstract class MyButton {
  Widget build(BuildContext context, VoidCallback onPressed, String text);
}
