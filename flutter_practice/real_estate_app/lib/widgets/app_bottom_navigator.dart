import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class AppBottomNavigator extends StatelessWidget {
  final selected;
  const AppBottomNavigator({super.key, this.selected});

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
          AppIconButton(icon: Icons.home, selected: selected == 1),
          AppIconButton(icon: Icons.favorite, selected: selected == 2),
          AppIconButton(icon: Icons.price_change, selected: selected == 3),
          AppIconButton(icon: Icons.calendar_month, selected: selected == 4),
          AppIconButton(icon: Icons.settings, selected: selected == 5),
        ],
      ),
    );
  }
}
