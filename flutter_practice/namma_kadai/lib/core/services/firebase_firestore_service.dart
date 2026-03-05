import 'package:firebase_auth/firebase_auth.dart';
import '../../model/user_model.dart';
import '../../model/order.dart';

abstract class FirebaseFirestoreService {
  /// Save user data in Firestore
  Future<void> saveUserData(
    User user, {
    String? name,
    String? username,
    String? gender,
  });

  /// Fetch user data from Firestore
  Stream<UserModel?> getUserData(String userId);

  /// Save an order for a specific user
  Future<void> saveOrder(String userId, Map<String, dynamic> orderData);

  /// Fetch order history for a specific user
  Stream<List<Order>> getOrderHistory(String userId);
}