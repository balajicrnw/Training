import 'package:design_patterns/template_pattern/calculators/bmi_calculator.dart';
import 'package:flutter/material.dart';
import '../calculators/json_bmi_calculator.dart';
import '../calculators/xml_bmi_calculator.dart';
import '../calculators/teen_bmi_calculator.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {

  late BmiCalculator calculator;
  List students = [];

  @override
  void initState() {
    super.initState();
    calculator = JsonBmiCalculator();
  }

  void run() {
    setState(() {
      students = calculator.calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Template Method")),
      body: Column(
        children: [

          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  calculator = JsonBmiCalculator();
                }),
                child: const Text("JSON"),
              ),

              ElevatedButton(
                onPressed: () => setState(() {
                  calculator = XmlBmiCalculator();
                }),
                child: const Text("XML"),
              ),

              ElevatedButton(
                onPressed: () => setState(() {
                  calculator = TeenBmiCalculator();
                }),
                child: const Text("Teen"),
              ),
            ],
          ),

          ElevatedButton(
            onPressed: run,
            child: const Text("Calculate BMI"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, i) {
                final s = students[i];
                return ListTile(
                  title: Text(s.name),
                  subtitle: Text("BMI: ${s.bmi.toStringAsFixed(2)}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}