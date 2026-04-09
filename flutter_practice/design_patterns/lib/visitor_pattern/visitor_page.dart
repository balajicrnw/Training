import 'package:design_patterns/visitor_pattern/domain/clothing_item.dart';
import 'package:design_patterns/visitor_pattern/domain/electronics_item.dart';
import 'package:design_patterns/visitor_pattern/domain/food_item.dart';
import 'package:design_patterns/visitor_pattern/visitors/invoice_visitor.dart';
import 'package:design_patterns/visitor_pattern/visitors/tax_calculation_visitor.dart';
import 'package:flutter/material.dart';

class VisitorPage extends StatefulWidget {
  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  late List items;

  String invoiceResult = "";
  String taxResult = "";

  @override
  void initState() {
    super.initState();

    items = [
      ElectronicsItem(10000),
      ClothingItem(2000),
      FoodItem(500),
    ];
  }

  void calculate() {
    final invoiceVisitor = InvoiceVisitor();
    final taxVisitor = TaxVisitor();

    for (var item in items) {
      item.accept(invoiceVisitor);
      item.accept(taxVisitor);
    }

    setState(() {
      invoiceResult = "Total Invoice: ₹${invoiceVisitor.total}";
      taxResult = "Total Tax: ₹${taxVisitor.tax}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visitor Pattern UI")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🛒 Order Items", style: TextStyle(fontSize: 20)),

            SizedBox(height: 10),

            ...items.map((e) => Card(
              child: ListTile(
                title: Text(e.runtimeType.toString()),
                subtitle: Text("Price: ₹${e.price}"),
              ),
            )),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculate,
              child: Text("Calculate Invoice & Tax"),
            ),

            SizedBox(height: 20),

            Text(invoiceResult, style: TextStyle(fontSize: 18)),
            Text(taxResult, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}