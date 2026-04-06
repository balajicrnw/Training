// coffee_page.dart
import 'package:flutter/material.dart';
import '../coffee/simple_coffee.dart';
import '../coffee/milk.dart';
import '../coffee/sugar.dart';
import '../coffee/chocolate.dart';
import '../coffee/coffee.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  bool milk = false;
  bool sugar = false;
  bool chocolate = false;

  Coffee getCoffee() {
    Coffee coffee = SimpleCoffee();

    if (milk) coffee = Milk(coffee);
    if (sugar) coffee = Sugar(coffee);
    if (chocolate) coffee = Chocolate(coffee);

    return coffee;
  }

  @override
  Widget build(BuildContext context) {
    final coffee = getCoffee();

    return Scaffold(
      appBar: AppBar(title: const Text("Coffee Decorator")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coffee.getDescription(),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              "Total: ₹${coffee.getCost()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            CheckboxListTile(
              title: const Text("Milk"),
              value: milk,
              onChanged: (v) => setState(() => milk = v!),
            ),
            CheckboxListTile(
              title: const Text("Sugar"),
              value: sugar,
              onChanged: (v) => setState(() => sugar = v!),
            ),
            CheckboxListTile(
              title: const Text("Chocolate"),
              value: chocolate,
              onChanged: (v) => setState(() => chocolate = v!),
            ),
          ],
        ),
      ),
    );
  }
}