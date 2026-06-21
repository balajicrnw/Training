import 'package:flutter/material.dart';

import '../ui.dart';

class AppTrailing extends StatelessWidget {
  const AppTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(132, 239, 238, 238),
          ),
        ),

        SizedBox(width: 4),
        Container(
          height: 6,
          width: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.black,
          ),
        ),
        SizedBox(width: 4),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(132, 239, 238, 238),
          ),
        ),
        SizedBox(width: 4),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(132, 239, 238, 238),
          ),
        ),
        SizedBox(width: 4),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(132, 239, 238, 238),
          ),
        ),
        SizedBox(width: 4),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(132, 239, 238, 238),
          ),
        ),
      ],
    );
  }
}
