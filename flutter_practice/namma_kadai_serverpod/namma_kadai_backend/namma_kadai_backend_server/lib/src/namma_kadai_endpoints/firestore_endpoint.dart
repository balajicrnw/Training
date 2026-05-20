// import 'package:serverpod/serverpod.dart';
// import '../namma_kadai_services/api_impl.dart';

// class FirestoreEndpoint extends Endpoint {
//   final api = ApiImpl();

//   Future<void> seedProducts(Session session) async {
//     await api.seedProducts();
//   }

//   Future<void> createProduct(Session session, Map<String, dynamic> data) async {
//     await api.saveProduct(data);
//   }

//   Future<void> updateProduct(Session session, Map<String, dynamic> data) async {
//     await api.saveProduct(data);
//   }

//   Future<void> deleteProduct(Session session, String id) async {
//     await api.deleteProduct(id);
//   }

//   Future<void> updateCartQuantity(Session session, String userId, String productId, int quantity) async {
//     api.currentUserId = userId;
//     await api.updateCartQuantity(productId, quantity);
//   }

//   Future<void> removeFromCart(Session session, String userId, String productId) async {
//     api.currentUserId = userId;
//     await api.removeFromCart(productId);
//   }

//   Future<void> clearCart(Session session, String userId) async {
//     api.currentUserId = userId;
//     await api.clearCart();
//   }
// }
