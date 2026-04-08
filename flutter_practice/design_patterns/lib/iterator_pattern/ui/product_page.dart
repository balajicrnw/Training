import 'package:flutter/material.dart';
import '../collection/product_collection.dart';
import '../iterator/product_iterator.dart';
import '../model/product.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductIterator iterator;

  Product? currentProduct;

  @override
  void initState() {
    super.initState();

    final collection = ProductCollection([
      Product("Laptop"),
      Product("Phone"),
      Product("Headphones"),
      Product("Keyboard"),
      Product("Mouse"),
    ]);

    iterator = ProductIterator(collection);
  }

  void showNext() {
    setState(() {
      currentProduct = iterator.next();
    });
  }

  void reset() {
    setState(() {
      iterator.reset();
      currentProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Iterator Pattern Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentProduct?.name ?? "Press Next",
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: showNext,
              child: Text("Next Product"),
            ),

            ElevatedButton(
              onPressed: reset,
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}