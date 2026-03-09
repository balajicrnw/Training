import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/storage_service.dart';
import '../model/order.dart';
import '../model/user_model.dart';
import '../model/serializers.dart';
import '../model/product.dart';
import '../model/cart_item.dart';

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
      final snapshot = await _firestore.collection(_productsCollection).limit(1).get();
      if (snapshot.docs.isNotEmpty) return;

      final productData = [
        {
          'title': 'Namma Filter Coffee',
          'description': 'Pure roasted South Indian coffee blend for the perfect morning.',
          'price': 299.0,
          'imageUrl': 'https://plus.unsplash.com/premium_photo-1675435644687-562e8042b9db?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29mZmVlfGVufDB8fDB8fHww',
          'category': 'Coffee',
        },
        {
          'title': 'Royal Silk Saree',
          'description': 'Exquisite Kanchipuram silk with handcrafted gold zari work.',
          'price': 8500.0,
          'imageUrl': 'https://images.unsplash.com/photo-1618901185975-d59f7091bcfe?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2lsayUyMHNhcmVlfGVufDB8fDB8fHww',
          'category': 'Fashion',
        },
        {
          'title': 'Premium Leather Boots',
          'description': 'Hand-stitched genuine leather boots for everlasting style.',
          'price': 4200.0,
          'imageUrl': 'https://images.unsplash.com/photo-1605812860427-4024433a70fd?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'category': 'Fashion',
        },
        {
          'title': 'Sony PlayStation 5',
          'description': 'Experience lightning-fast loading and immersive 4K gaming.',
          'price': 54999.0,
          'imageUrl': 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?q=80&w=2070&auto=format&fit=crop',
          'category': 'Electronics',
        },
        {
          'title': 'AirPod Max Silver',
          'description': 'A perfect balance of exhilarating high-fidelity audio.',
          'price': 59900.0,
          'imageUrl': 'https://images.unsplash.com/photo-1613040809024-b4ef7ba99bc3?q=80&w=2070&auto=format&fit=crop',
          'category': 'Electronics',
        },
        {
          'title': 'Classic Chronograph',
          'description': 'Timeless design meets modern precision engineering.',
          'price': 12500.0,
          'imageUrl': 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?q=80&w=2070&auto=format&fit=crop',
          'category': 'Electronics',
        },
        {
          'title': 'Eames Lounge Chair',
          'description': 'The ultimate icon of mid-century modern luxury.',
          'price': 24000.0,
          'imageUrl': 'https://images.unsplash.com/photo-1519947486511-46149fa0a254?q=80&w=1974&auto=format&fit=crop',
          'category': 'Home',
        },
        {
          'title': 'Professional Drone',
          'description': 'Capture breathtaking 4K footage from the skies.',
          'price': 89000.0,
          'imageUrl': 'https://plus.unsplash.com/premium_photo-1714618849685-89cad85746b1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZHJvbmV8ZW58MHx8MHx8fDA%3D',
          'category': 'Electronics',
        },
        {
          'title': 'Organic Honey Blend',
          'description': 'Pure, unadulterated honey sourced from hill tribes.',
          'price': 450.0,
          'imageUrl': 'https://images.unsplash.com/photo-1620101680144-eb3195b64514?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aG9uZXklMjBibGVuZHxlbnwwfHwwfHx8MA%3D%3D',
          'category': 'Coffee',
        },
        {
          'title': 'Cast Iron Skillet',
          'description': 'Heavy-duty cookware for restaurant-style searing.',
          'price': 2100.0,
          'imageUrl': 'https://plus.unsplash.com/premium_photo-1716488286931-79cef654e08c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Q2FzdCUyMElyb24lMjBTa2lsbGV0fGVufDB8fDB8fHww',
          'category': 'Home',
        },
        {
          'title': 'Bamboo Table Lamp',
          'description': 'Eco-friendly lighting that adds warmth to any room.',
          'price': 1800.0,
          'imageUrl': 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?q=80&w=2070&auto=format&fit=crop',
          'category': 'Home',
        },
        {
          'title': 'Linen Summer Shirt',
          'description': 'Lightweight and breathable linen for hot climates.',
          'price': 1500.0,
          'imageUrl': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1976&auto=format&fit=crop',
          'category': 'Fashion',
        },
      ];

      final batch = _firestore.batch();
      for (var data in productData) {
        final docRef = _firestore.collection(_productsCollection).doc();
        batch.set(docRef, data);
      }
      await batch.commit();
    } catch (e) {
      print('Error seeding Firestore products: $e');
    }
  }

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
          
          final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
          data['id'] = doc.id;
          

          if (data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp).toDate().microsecondsSinceEpoch;
          }

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
  Future<void> insertProduct(Product product) async {
    try {
      final data = serializers.serializeWith(Product.serializer, product) as Map<String, dynamic>;
      if (product.id != null) {
        await _firestore.collection(_productsCollection).doc(product.id!).set(data);
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

  CollectionReference _ordersCollection(String userId) => 
      _firestore.collection(_usersCollection).doc(userId).collection(_ordersCollectionName);

  @override
  Future<List<CartItem>> getCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    
    try {
      final snapshot = await _cartCollection(user.uid).get();
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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final data = serializers.serializeWith(CartItem.serializer, item) as Map<String, dynamic>;
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
      await _cartCollection(user.uid).doc(productId).update({'quantity': quantity});
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
      await _ordersCollection(order.uid!).add({
        ...orderData,
        _orderDateField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving order: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Order>> getOrders(String userId) {
    return _ordersCollection(userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
            data['id'] = doc.id;
            
            if (data['orderDate'] is Timestamp) {
              data['dateTime'] = (data['orderDate'] as Timestamp).toDate().microsecondsSinceEpoch;
            }

            return serializers.deserializeWith(Order.serializer, data)!;
          }).toList();
        });
  }

  @override
  Map<String, dynamic> serializeOrder(Order order) {
    return serializers.serializeWith(Order.serializer, order) as Map<String, dynamic>;
  }

  @override
  Order deserializeOrder(Map<String, dynamic> map) {
    return serializers.deserializeWith(Order.serializer, map) as Order;
  }
}
