import 'package:flutter/material.dart';

import 'math_operation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SourceGen Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController firstController = TextEditingController();

  final TextEditingController secondController = TextEditingController();

  String selectedOperation = '+';

  String result = '';

  void generateExpression() {
    final int a = int.tryParse(firstController.text) ?? 0;

    final int b = int.tryParse(secondController.text) ?? 0;

    String output = '';

    switch (selectedOperation) {
      case '+':
        output = addExpression(a, b);
        break;

      case '-':
        output = subtractExpression(a, b);
        break;

      case '*':
        output = multiplyExpression(a, b);
        break;

      case '/':
        output = divideExpression(a, b);
        break;
    }

    setState(() {
      result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SourceGen Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            TextField(
              controller: firstController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedOperation,
              decoration: InputDecoration(
                labelText: 'Select Operation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: '+', child: Text('Addition (+)')),
                DropdownMenuItem(value: '-', child: Text('Subtraction (-)')),
                DropdownMenuItem(value: '*', child: Text('Multiplication (*)')),
                DropdownMenuItem(value: '/', child: Text('Division (/)')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedOperation = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: generateExpression,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Calculate', style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Generated Expression',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    result.isEmpty ? 'No Expression' : result,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
