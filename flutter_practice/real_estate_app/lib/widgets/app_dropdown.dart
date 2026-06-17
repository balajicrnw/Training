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
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: [
            DropdownMenuItem(child: Text("11 Floor")),
            DropdownMenuItem(child: Text("12 Floor")),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
