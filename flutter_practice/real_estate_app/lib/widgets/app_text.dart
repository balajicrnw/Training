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
        return Text(
          text,
          style: TextStyle(
            fontSize: 8,
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        );
      case AppTextVariant.medium:
        return Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 40, 39, 39),
            fontWeight: FontWeight.bold,
          ),
        );
      case AppTextVariant.large:
        return Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: const Color.fromARGB(255, 34, 34, 34),
          ),
        );
    }
  }
}
