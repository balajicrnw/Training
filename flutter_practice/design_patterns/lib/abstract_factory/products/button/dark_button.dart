import 'package:flutter/material.dart';
import 'my_button.dart';

class DarkButton implements MyButton {
  @override
  Widget build(BuildContext context, VoidCallback onPressed, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.amber, width: 1),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
