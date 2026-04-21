import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../core/services/storage_service.dart';
import '../core/services/auth_service.dart';
import '../model/order.dart';
import '../model/user_model.dart';
import '../model/serializers.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../data/product_seed_data.dart';

class FirebaseFirestoreServiceImpl implements StorageService {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreServiceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _usersCollection = 'users';
  static const String _ordersCollectionName = 'orders';
  static const String _orderDateField = 'orderDate';
  static const String _productsCollection = 'products';

  @override
  Future<void> init() async {
    await _seedProducts();
  }

  Future<void> _seedProducts() async {
    try {
      final snapshot =
          await _firestore.collection(_productsCollection).limit(1).get();
      if (snapshot.docs.isNotEmpty) return;

      final batch = _firestore.batch();
      for (final data in kProductSeedData) {
        final docRef = _firestore.collection(_productsCollection).doc();
        batch.set(docRef, Map<String, dynamic>.from(data));
      }
      await batch.commit();
    } catch (e) {
      print('Error seeding Firestore products: $e');
    }
  }

  @override
  Future<void> saveUserData(
    AuthUser user, {
    String? name,
    String? username,
    String? gender,
    String? profileImageUrl,
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
          .doc(user.id)
          .set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  @override
  Future<String?> uploadProfilePhoto(String userId, String filePath) async {
    // Firebase implementation would use Firebase Storage
    return null;
  }

  @override
  Stream<UserModel?> getUserData(String userId) {
    return _firestore.collection(_usersCollection).doc(userId).snapshots().map((
      doc,
    ) {
      if (!doc.exists || doc.data() == null) return null;

      final data = Map<String, dynamic>.from(
        doc.data() as Map<String, dynamic>,
      );
      data['id'] = doc.id;

      if (data['createdAt'] is Timestamp) {
        data['createdAt'] =
            (data['createdAt'] as Timestamp).toDate().microsecondsSinceEpoch;
      }

      return serializers.deserializeWith(UserModel.serializer, data);
    });
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firestore.collection(_productsCollection).get();
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(
          doc.data() as Map<String, dynamic>,
        );
        data['id'] = doc.id;
        return serializers.deserializeWith(Product.serializer, data) as Product;
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(_productsCollection).add(data);
    } catch (e) {
      print('Error saving product to Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<void> seedProducts() async {
    for (final p in kProductSeedData) {
      await saveProduct(Map<String, dynamic>.from(p));
    }
  }

  @override
  Future<void> insertProduct(Product product) async {
    try {
      final data = serializers.serializeWith(Product.serializer, product)
          as Map<String, dynamic>;
      if (product.id != null) {
        await _firestore
            .collection(_productsCollection)
            .doc(product.id!)
            .set(data);
      } else {
        await _firestore.collection(_productsCollection).add(data);
      }
    } catch (e) {
      print('Error inserting product: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await _firestore.collection(_productsCollection).doc(id).delete();
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  CollectionReference _cartCollection(String userId) =>
      _firestore.collection(_usersCollection).doc(userId).collection('cart');

  CollectionReference _ordersCollection(String userId) => _firestore
      .collection(_usersCollection)
      .doc(userId)
      .collection(_ordersCollectionName);

  @override
  Future<List<CartItem>> getCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    try {
      final snapshot = await _cartCollection(user.uid).get();
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(
          doc.data() as Map<String, dynamic>,
        );
        data['id'] = doc.id;
        return serializers.deserializeWith(CartItem.serializer, data)
            as CartItem;
      }).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final data = serializers.serializeWith(CartItem.serializer, item)
          as Map<String, dynamic>;
      await _cartCollection(user.uid).doc(item.productId).set(data);
    } catch (e) {
      print('Error adding to cart: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCartQuantity(String productId, int quantity) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _cartCollection(
        user.uid,
      ).doc(productId).update({'quantity': quantity});
    } catch (e) {
      print('Error updating cart quantity: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _cartCollection(user.uid).doc(productId).delete();
    } catch (e) {
      print('Error removing from cart: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _cartCollection(user.uid).get();
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveOrder(Order order) async {
    try {
      final orderData = serializeOrder(order);
      await _ordersCollection(
        order.uid!,
      ).add({...orderData, _orderDateField: FieldValue.serverTimestamp()});
    } catch (e) {
      print('Error saving order: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Order>> getOrders(String userId) {
    return _ordersCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(
          doc.data() as Map<String, dynamic>,
        );
        data['id'] = doc.id;

        if (data['orderDate'] is Timestamp) {
          data['dateTime'] =
              (data['orderDate'] as Timestamp).toDate().microsecondsSinceEpoch;
        }

        return serializers.deserializeWith(Order.serializer, data)!;
      }).toList();
    });
  }

  @override
  Map<String, dynamic> serializeOrder(Order order) {
    return serializers.serializeWith(Order.serializer, order)
        as Map<String, dynamic>;
  }

  @override
  Order deserializeOrder(Map<String, dynamic> map) {
    return serializers.deserializeWith(Order.serializer, map) as Order;
  }

  @override
  Future<String?> uploadProfilePhotoBytes(
    String userId,
    List<int> bytes,
    String fileName,
  ) async {
    return null;
  }
}
