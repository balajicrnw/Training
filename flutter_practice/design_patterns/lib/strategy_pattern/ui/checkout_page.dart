import 'package:design_patterns/strategy_pattern/models/package_size.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../strategies/shipping_strategy.dart';
import '../strategies/pickup_strategy.dart';
import '../strategies/parcel_strategy.dart';
import '../strategies/priority_strategy.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Order order = Order();

  late List<ShippingStrategy> strategies;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    strategies = [
      PickupStrategy(),
      ParcelStrategy(),
      PriorityStrategy(),
    ];

    // sample items
    order.items.addAll([
      OrderItem(name: "Book", price: 100, size: PackageSize.s),
      OrderItem(name: "Shoes", price: 500, size: PackageSize.l),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final strategy = strategies[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Strategy Pattern")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text("Select Shipping Method:"),

            for (int i = 0; i < strategies.length; i++)
              RadioListTile(
                title: Text(strategies[i].label),
                value: i,
                groupValue: selectedIndex,
                onChanged: (val) {
                  setState(() => selectedIndex = val!);
                },
              ),

            const SizedBox(height: 20),

            Text("Subtotal: ₹${order.total}"),
            Text("Shipping: ₹${strategy.calculate(order)}"),
            Text("Grand Total: ₹${order.total + strategy.calculate(order)}"),
          ],
        ),
      ),
    );
  }
}