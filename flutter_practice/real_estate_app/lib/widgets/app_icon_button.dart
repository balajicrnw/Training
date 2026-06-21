import 'package:flutter/material.dart';

import '../ui.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function? onTap;
  final AppIconButtonVariant variant;

  const AppIconButton({
    super.key,
    required this.icon,
    this.selected = false,
    this.onTap,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppIconButtonVariant.background:
        return selected
            ? Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xfff7fd8e),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    onTap?.call();
                  },
                  icon: Icon(icon, size: 20),
                ),
              )
            : Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xfff8fcfd),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.navBarBackground),
                ),
                child: IconButton(
                  onPressed: () {
                    onTap?.call();
                  },
                  icon: Icon(icon, size: 20),
                ),
              );

      case AppIconButtonVariant.transparent:
        return Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.navBarBackground),
          ),
          child: IconButton(
            onPressed: () {
              onTap?.call();
            },
            icon: Icon(icon, size: 20),
          ),
        );

      case AppIconButtonVariant.transparentBorder:
        return Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: const Color.fromARGB(91, 69, 69, 69)),
          ),
          child: IconButton(
            onPressed: () {
              onTap?.call();
            },
            icon: Icon(icon, size: 20),
          ),
        );
    }
  }
}
