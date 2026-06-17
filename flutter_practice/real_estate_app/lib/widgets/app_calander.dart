import 'package:flutter/material.dart';

class AppCalander extends StatelessWidget {
  const AppCalander({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromARGB(161, 228, 240, 158),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2077),
        onDateChanged: (DateTime date) {},
      ),
    );
  }
}
