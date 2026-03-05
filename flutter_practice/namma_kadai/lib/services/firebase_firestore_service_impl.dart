import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/firebase_firestore_service.dart';
import '../model/order.dart';
import '../model/user_model.dart';
import '../model/serializers.dart';

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
  Stream<UserModel?> getUserData(String userId) {
    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) {
          if (!doc.exists || doc.data() == null) return null;
          
          final data = Map<String, dynamic>.from(doc.data()!);
          data['id'] = doc.id;
          

          if (data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp).toDate().microsecondsSinceEpoch;
          }

          return serializers.deserializeWith(UserModel.serializer, data);
        });
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
  Stream<List<Order>> getOrderHistory(String userId) {
    return _firestore
        .collection(_ordersCollection)
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = Map<String, dynamic>.from(doc.data());
            data['id'] = doc.id;
            
            if (data['orderDate'] is Timestamp) {
              data['dateTime'] = (data['orderDate'] as Timestamp).toDate().microsecondsSinceEpoch;
            }

            return serializers.deserializeWith(Order.serializer, data)!;
          }).toList();
        });
  }
}
