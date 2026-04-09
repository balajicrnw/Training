import 'package:design_patterns/state_pattern/context/order_context.dart';
import 'package:flutter/material.dart';
import '../model/order.dart';

class StatePage extends StatefulWidget {
  const StatePage({super.key});

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  final OrderContext order = OrderContext(
    Order(
      id: "101",
      productName: "Laptop",
      price: 50000,
      quantity: 1,
    ),
  );

  void changeStatus() {
    setState(() {
      order.next();
    });
  }

  Color getStatusColor() {
    switch (order.stateName) {
      case "Pending":
        return Colors.orange;
      case "Shipped":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order State Pattern")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: ${order.order.id}"),
            Text("Product: ${order.order.productName}"),
            Text("Price: ₹${order.order.price}"),
            Text("Quantity: ${order.order.quantity}"),
            Text("Total: ₹${order.order.total}"),
            const SizedBox(height: 20),

            Text(
              "Status: ${order.stateName}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: getStatusColor(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: changeStatus,
              child: const Text("Next State"),
            ),
          ],
        ),
      ),
    );
  }
}