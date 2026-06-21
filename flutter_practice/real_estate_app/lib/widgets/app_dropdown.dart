import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({super.key});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: const Color.fromARGB(255, 240, 239, 239)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "11 Floor",
          padding: EdgeInsets.zero,
          isExpanded: true,
          items: [
            DropdownMenuItem<String>(
              value: "11 Floor",
              child: Text(
                "11 Floor",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            DropdownMenuItem<String>(
              value: "12 Floor",
              child: Text("12 Floor", style: TextStyle(fontSize: 14)),
            ),
          ],
          onChanged: (String? value) {},
        ),
      ),
    );
  }
}
