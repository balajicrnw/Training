import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class AppArea extends StatelessWidget {
  const AppArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Positioned(
          right: 14,
          top: 10,
          child: Column(
            children: [
              Text(
                "21K",
                style: TextStyle(fontSize: 12, color: AppColors.darkYellow),
              ),
              Text(
                "sq ft",
                style: TextStyle(fontSize: 8, color: AppColors.darkYellow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
