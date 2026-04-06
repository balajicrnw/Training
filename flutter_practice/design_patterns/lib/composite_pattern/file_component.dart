// file_component.dart
import 'package:flutter/material.dart';

abstract class FileComponent {
  int getSize();
  Widget buildWidget();
}