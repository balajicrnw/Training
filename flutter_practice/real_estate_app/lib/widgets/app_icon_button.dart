import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;

  const AppIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: IconButton(onPressed: () {}, icon: Icon(icon, size: 20)),
    );
  }
}
