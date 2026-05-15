import 'package:namma_kadai/services/firebase_firestore_service_impl.dart';
import 'package:serverpod/serverpod.dart';

class FirestoreEndpoint extends Endpoint {
  final firebase = FirebaseFirestoreServiceImpl();

  Future<void> seedProducts(Session session) async {
    await firebase.seedProducts();
  }

  // Product operations
  Future<void> createProduct(Session session, Map<String, dynamic> data) async {
    await firebase.saveProduct(data);
  }

  Future<void> updateProduct(Session session, Map<String, dynamic> data) async {
    await firebase.saveProduct(data);
  }

  Future<void> deleteProduct(Session session, String id) async {
    await firebase.deleteProduct(id);
  }

  // Cart operations
  Future<void> updateCartQuantity(Session session, String productId, int quantity) async {
    await firebase.updateCartQuantity(productId, quantity);
  }

  Future<void> removeFromCart(Session session, String productId) async {
    await firebase.removeFromCart(productId);
  }

  Future<void> clearCart(Session session) async {
    await firebase.clearCart();
  }
}