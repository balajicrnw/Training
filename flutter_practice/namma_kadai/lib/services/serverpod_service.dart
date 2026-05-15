import 'package:namma_kadai_backend_client/namma_kadai_backend_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serverpodServiceProvider = Provider((ref) => ServerpodService());

class ServerpodService {
  late Client client;

  ServerpodService() {
    client = Client(
      'http://localhost:8080/',
    )..connectivityMonitor = FlutterConnectivityMonitor();
  }

  // Products
  Future<void> seedProducts() async {
    await client.firestore.seedProducts();
  }

  Future<void> createProduct(Map<String, dynamic> data) async {
    await client.firestore.createProduct(data);
  }

  Future<void> updateProduct(Map<String, dynamic> data) async {
    await client.firestore.updateProduct(data);
  }

  Future<void> deleteProduct(String id) async {
    await client.firestore.deleteProduct(id);
  }

  // Cart
  Future<void> updateCartQuantity(String productId, int quantity) async {
    await client.firestore.updateCartQuantity(productId, quantity);
  }

  Future<void> removeFromCart(String productId) async {
    await client.firestore.removeFromCart(productId);
  }

  Future<void> clearCart() async {
    await client.firestore.clearCart();
  }

  // Add other methods as needed based on the endpoint...
}
