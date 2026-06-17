import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({super.key});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "11 Floor",
          items: [
            DropdownMenuItem<String>(
              value: "11 Floor",
              child: Text("11 Floor"),
            ),
            DropdownMenuItem<String>(
              value: "12 Floor",
              child: Text("12 Floor"),
            ),
          ],
          onChanged: (String? value) {},
        ),
      ),
    );
  }
}
