import 'package:design_patterns/command_pattern/add_item.dart';
import 'package:design_patterns/command_pattern/cart.dart';
import 'package:design_patterns/command_pattern/history.dart';
import 'package:design_patterns/command_pattern/remove_item.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cart = Cart();
  final history = CommandHistory();

  final List<String> products = [
    "Laptop",
    "Phone",
    "Headphones",
    "Keyboard",
    "Mouse",
  ];

  String selectedItem = "Laptop";

  void addItem() {
    history.execute(AddItemCommand(cart, selectedItem));
    setState(() {});
  }

  void removeItem() {
    history.execute(RemoveItemCommand(cart, selectedItem));
    setState(() {});
  }

  void undo() {
    history.undo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart (Command Pattern)")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cart Items:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Column(
              children: cart.items.isEmpty
                  ? [Text("Cart is empty", style: TextStyle(fontSize: 16))]
                  : cart.items
                        .map(
                          (item) => Text(item, style: TextStyle(fontSize: 16)),
                        )
                        .toList(),
            ),

            SizedBox(height: 30),

            // 🔽 Dropdown to select item
            DropdownButton<String>(
              value: selectedItem,
              items: products.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value!;
                });
              },
            ),

            SizedBox(height: 20),

            // ➕ Add Button
            ElevatedButton(onPressed: addItem, child: Text("Add Item")),

            // ➖ Remove Button
            ElevatedButton(onPressed: removeItem, child: Text("Remove Item")),

            SizedBox(height: 20),

            // ↩ Undo Button
            ElevatedButton(
              onPressed: undo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Undo Last Action"),
            ),
          ],
        ),
      ),
    );
  }
}
