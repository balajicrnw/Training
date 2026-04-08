import 'package:design_patterns/interpreter_pattern/parser.dart';
import 'package:flutter/material.dart';

class InterpreterUI extends StatefulWidget {
  @override
  State<InterpreterUI> createState() => _InterpreterUIState();
}

class _InterpreterUIState extends State<InterpreterUI> {
  final TextEditingController controller = TextEditingController();

  String result = "";

  void calculate() {
    try {
      final expression = Parser.build(controller.text);
      setState(() {
        result = expression.interpret().toString();
      });
    } catch (e) {
      setState(() {
        result = "Invalid Expression";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interpreter Pattern Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter postfix expression",
                hintText: "e.g. 2 3 +",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculate,
              child: const Text("Evaluate"),
            ),

            const SizedBox(height: 30),

            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}