import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class AppBottomNavigator extends StatelessWidget {
  final selected;
  final Function onTap;
  AppBottomNavigator({super.key, this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.navBarBackground,
      ),
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIconButton(
            icon: selected == 1 ? Icons.home : Icons.home_outlined,
            selected: selected == 1,
            onTap: () => onTap(1),
            variant: AppIconButtonVariant.background,
          ),
          AppIconButton(
            icon: selected == 2 ? Icons.search : Icons.search_outlined,
            selected: selected == 2,
            onTap: () => onTap(2),
            variant: AppIconButtonVariant.background,
          ),
          AppIconButton(
            icon: selected == 3
                ? Icons.price_change
                : Icons.price_change_outlined,
            selected: selected == 3,
            onTap: () => onTap(3),
            variant: AppIconButtonVariant.background,
          ),
          AppIconButton(
            icon: selected == 4
                ? Icons.calendar_month
                : Icons.calendar_month_outlined,
            selected: selected == 4,
            onTap: () => onTap(4),
            variant: AppIconButtonVariant.background,
          ),
          AppIconButton(
            icon: selected == 5 ? Icons.settings : Icons.settings_outlined,
            selected: selected == 5,
            onTap: () => onTap(5),
            variant: AppIconButtonVariant.background,
          ),
        ],
      ),
    );
  }
}
