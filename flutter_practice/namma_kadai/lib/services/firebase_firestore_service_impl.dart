import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/firebase_firestore_service.dart';

class FirebaseFirestoreServiceImpl implements FirebaseFirestoreService {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreServiceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _usersCollection = 'users';
  static const String _ordersCollection = 'orders';
  static const String _orderDateField = 'orderDate';

  @override
  Future<void> saveUserData(
    User user, {
    String? name,
    String? username,
    String? gender,
  }) async {
    try {
      final userData = <String, dynamic>{
        'email': user.email,
        'name': name,
        'username': username,
        'gender': gender,
        'createdAt': FieldValue.serverTimestamp(),
      };
     
      userData.removeWhere((key, value) => value == null);

      await _firestore
          .collection(_usersCollection)
          .doc(user.uid)
          .set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final doc =
          await _firestore.collection(_usersCollection).doc(userId).get();
      return doc.data();
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveOrder(String userId, Map<String, dynamic> orderData) async {
    try {
      await _firestore.collection(_ordersCollection).add({
        ...orderData,
        'uid': userId,
        _orderDateField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving order: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getOrderHistory(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_ordersCollection)
          .where('uid', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      print('Error fetching order history: $e');
      rethrow;
    }
  }
}