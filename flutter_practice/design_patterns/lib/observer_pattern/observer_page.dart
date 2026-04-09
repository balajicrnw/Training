import 'package:design_patterns/observer_pattern/model/calculator_data.dart';
import 'package:design_patterns/observer_pattern/observer/addition.dart';
import 'package:design_patterns/observer_pattern/observer/division.dart';
import 'package:design_patterns/observer_pattern/observer/multiplication.dart';
import 'package:design_patterns/observer_pattern/observer/subtraction.dart';
import 'package:design_patterns/observer_pattern/subject/calculator_manager.dart';
import 'package:flutter/material.dart';



class ObserverPage extends StatefulWidget {
  @override
  _ObserverPageState createState() => _ObserverPageState();
}

class _ObserverPageState extends State<ObserverPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  final manager = CalculatorManager();

  final add = Addition();
  final sub = Subtraction();
  final mul = Multiplication();
  final div = Division();

  @override
  void initState() {
    super.initState();
    manager.subscribe(add);
    manager.subscribe(sub);
    manager.subscribe(mul);
    manager.subscribe(div);
  }

  void calculate() {
    final a = double.tryParse(controller1.text) ?? 0;
    final b = double.tryParse(controller2.text) ?? 0;

    manager.notify(CalculatorData(a, b));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Observer Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: controller1, decoration: InputDecoration(labelText: "Number 1")),
            TextField(controller: controller2, decoration: InputDecoration(labelText: "Number 2")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: calculate, child: Text("Calculate")),

            SizedBox(height: 20),

            Text("Addition: ${add.result}"),
            Text("Subtraction: ${sub.result}"),
            Text("Multiplication: ${mul.result}"),
            Text("Division: ${div.result}"),
          ],
        ),
      ),
    );
  }
}