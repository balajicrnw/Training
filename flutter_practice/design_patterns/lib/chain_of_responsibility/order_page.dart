import 'package:flutter/material.dart';
import 'order.dart';
import 'stock_handler.dart';
import 'payment_handler.dart';
import 'delivery_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderPage(),
    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String message = "Place an order";

  bool processOrder(Order order) {
    final stock = StockHandler();
    final payment = PaymentHandler();
    final delivery = DeliveryHandler();

    stock.linkWith(payment).linkWith(delivery);

    return stock.handle(order);
  }

  void placeOrder(Order order) {
    bool success = processOrder(order);

    setState(() {
      message = success
          ? "✅ Order placed successfully!"
          : "❌ Order failed!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chain of Responsibility - Order")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                placeOrder(Order(
                  item: "Laptop",
                  amount: 100000,
                  inStock: true,
                  paymentDone: true,
                ));
              },
              child: Text("Laptop"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                placeOrder(Order(
                  item: "Phone",
                  amount: 20000,
                  inStock: false,
                  paymentDone: true,
                ));
              },
              child: Text("Phone"),
            ),
          ],
        ),
      ),
    );
  }
}