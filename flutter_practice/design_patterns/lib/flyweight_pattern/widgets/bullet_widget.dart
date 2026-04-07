import 'package:flutter/material.dart';
import '../models/bullet.dart';

class BulletWidget extends StatelessWidget {
  final Bullet bullet;

  const BulletWidget({super.key, required this.bullet});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: bullet.x,
      top: bullet.y,
      child: Container(
        width: bullet.type.size,
        height: bullet.type.size,
        decoration: BoxDecoration(
          color: bullet.type.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}