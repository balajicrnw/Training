import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function? onTap;

  const AppIconButton({
    super.key,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return selected
        ? Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xfff7fd8e),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 206, 205, 205),
              ),
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
              border: Border.all(
                color: const Color.fromARGB(255, 206, 205, 205),
              ),
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
