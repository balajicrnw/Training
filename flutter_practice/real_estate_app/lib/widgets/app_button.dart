import 'package:flutter/material.dart';

import '../ui.dart';

class AppButton extends StatefulWidget {
  final String text;

  const AppButton({super.key, required this.text});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkYellow,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonTextColor,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 50,
              height: 25,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.buttonTextColor.withOpacity(0.4),
                      size: 20,
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.buttonTextColor.withOpacity(0.6),
                      size: 22,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.buttonTextColor.withOpacity(0.8),
                      size: 24,
                    ),
                  ),
                  const Positioned(
                    left: 18,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.buttonTextColor,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
