import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseFirestoreService {
  /// Save user data in Firestore
  Future<void> saveUserData(
    User user, {
    String? name,
    String? username,
    String? gender,
  });

  /// Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String userId);

  /// Save an order for a specific user
  Future<void> saveOrder(String userId, Map<String, dynamic> orderData);

  /// Fetch order history for a specific user
  Future<List<Map<String, dynamic>>> getOrderHistory(String userId);
}