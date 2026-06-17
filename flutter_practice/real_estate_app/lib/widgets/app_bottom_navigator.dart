import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class AppBottomNavigator extends StatelessWidget {
  const AppBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(255, 255, 255, 0.82),
      ),
      child: Row(
        spacing: 2,

        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIconButton(icon: Icons.home),
          AppIconButton(icon: Icons.favorite),
          AppIconButton(icon: Icons.price_change),
          AppIconButton(icon: Icons.calendar_month),
          AppIconButton(icon: Icons.settings),
        ],
      ),
    );
  }
}
