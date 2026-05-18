import 'package:namma_kadai_shared/namma_kadai_shared.dart';

class ApiImpl implements StorageService {
  final dynamic _firestore;
  String? currentUserId; // Set this before calling cart methods

  ApiImpl({dynamic firestore}) : _firestore = firestore;

  static const String _usersCollection = 'users';
  static const String _ordersCollectionName = 'orders';
  static const String _orderDateField = 'orderDate';
  static const String _productsCollection = 'products';

  @override
  Future<void> init() async {
    await seedProducts();
  }

  @override
  Future<void> seedProducts() async {
    try {
      final snapshot = await _firestore
          .collection(_productsCollection)
          .limit(1)
          .get();
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
        'createdAt': DateTime.now(),
      };

      userData.removeWhere((key, value) => value == null);

      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .set(userData, {'merge': true});
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  @override
  Stream<UserModel?> getUserData(String userId) {
    return _firestore.collection(_usersCollection).doc(userId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
      data['id'] = doc.id;
      return serializers.deserializeWith(UserModel.serializer, data);
    });
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firestore.collection(_productsCollection).get();
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
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
  Future<void> insertProduct(Product product) async {
    try {
      final data = serializers.serializeWith(Product.serializer, product) as Map<String, dynamic>;
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

  dynamic _cartCollection(String userId) =>
      _firestore.collection(_usersCollection).doc(userId).collection('cart');

  dynamic _ordersCollection(String userId) => _firestore
      .collection(_usersCollection)
      .doc(userId)
      .collection(_ordersCollectionName);

  @override
  Future<List<CartItem>> getCartItems() async {
    if (currentUserId == null) return [];
    try {
      final snapshot = await _cartCollection(currentUserId!).get();
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data['id'] = doc.id;
        return serializers.deserializeWith(CartItem.serializer, data) as CartItem;
      }).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    if (currentUserId == null) return;
    try {
      final data = serializers.serializeWith(CartItem.serializer, item) as Map<String, dynamic>;
      await _cartCollection(currentUserId!).doc(item.productId).set(data);
    } catch (e) {
      print('Error adding to cart: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCartQuantity(String productId, int quantity) async {
    if (currentUserId == null) return;
    try {
      await _cartCollection(currentUserId!).doc(productId).update({'quantity': quantity});
    } catch (e) {
      print('Error updating cart quantity: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    if (currentUserId == null) return;
    try {
      await _cartCollection(currentUserId!).doc(productId).delete();
    } catch (e) {
      print('Error removing from cart: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    if (currentUserId == null) return;
    try {
      final snapshot = await _cartCollection(currentUserId!).get();
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
      final orderData = serializers.serializeWith(Order.serializer, order) as Map<String, dynamic>;
      await _ordersCollection(order.uid!).add({
        ...orderData,
        _orderDateField: DateTime.now(),
      });
    } catch (e) {
      print('Error saving order: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Order>> getOrders(String userId) {
    return _ordersCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data['id'] = doc.id;
        return serializers.deserializeWith(Order.serializer, data)!;
      }).toList();
    });
  }

  @override
  Future<String?> uploadProfilePhotoBytes(String userId, List<int> bytes, String fileName) async {
    // Implement cloud storage logic if needed
    return null;
  }
}
