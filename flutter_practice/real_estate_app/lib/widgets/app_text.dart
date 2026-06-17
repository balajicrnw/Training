import 'package:flutter/material.dart';
import 'enums.dart';

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant appTextVariant;

  const AppText({super.key, required this.text, required this.appTextVariant});

  @override
  Widget build(BuildContext context) {
    switch (appTextVariant) {
      case AppTextVariant.small:
        return Text(text, style: TextStyle(fontSize: 10, color: Colors.white));
      case AppTextVariant.medium:
        return Text(text, style: TextStyle(fontSize: 25, color: Colors.white));
      case AppTextVariant.large:
        return Text(text, style: TextStyle(fontSize: 50, color: Colors.white));
    }
  }
}
