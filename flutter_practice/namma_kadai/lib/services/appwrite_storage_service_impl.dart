import 'package:appwrite/appwrite.dart';
import '../core/services/auth_service.dart';
import '../core/services/storage_service.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/user_model.dart';
import '../model/serializers.dart';
import '../config/environment.dart';
import 'dart:convert';

class AppwriteStorageServiceImpl implements StorageService {
  final Databases _databases;
  final Account _account;

  static const String _databaseId = Environment.appwriteDatabaseId;
  static const String _usersCollection = Environment.appwriteUsersCollectionId;
  static const String _productsCollection =
      Environment.appwriteProductsCollectionId;
  static const String _cartCollection = Environment.appwriteCartCollectionId;
  static const String _ordersCollection =
      Environment.appwriteOrdersCollectionId;

  AppwriteStorageServiceImpl({Databases? databases, Account? account})
    : _databases =
          databases ??
          Databases(
            Client()
                .setEndpoint(Environment.appwritePublicEndpoint)
                .setProject(Environment.appwriteProjectId)
                .setSelfSigned(status: true),
          ),
      _account =
          account ??
          Account(
            Client()
                .setEndpoint(Environment.appwritePublicEndpoint)
                .setProject(Environment.appwriteProjectId)
                .setSelfSigned(status: true),
          );

  @override
  Future<void> init() async {
    // Basic init, usually we create collections here if they don't exist, but skipping for brevity
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final user = await _account.get();
      final uid = user.$id;
      final pid = item.productId;

      // 1. Check if item already exists for this user in cart
      final existing = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _cartCollection,
        queries: [Query.equal('userId', uid), Query.equal('productId', pid)],
      );

      final data =
          serializers.serializeWith(CartItem.serializer, item)
              as Map<String, dynamic>;
      data['userId'] = uid;
      data.remove('id'); // Avoid ID conflicts

      if (existing.total > 0) {
        // 2. Update existing document
        final docId = existing.documents.first.$id;
        await _databases.updateDocument(
          databaseId: _databaseId,
          collectionId: _cartCollection,
          documentId: docId,
          data: data,
        );
        print('DEBUG: Item updated in cart: $docId');
      } else {
        // 3. Create new document with unique ID (guaranteed < 36 chars)
        await _databases.createDocument(
          databaseId: _databaseId,
          collectionId: _cartCollection,
          documentId: ID.unique(),
          data: data,
        );
        print('DEBUG: Item added to cart');
      }
    } catch (e) {
      print('CRITICAL: Error adding to cart: $e');
      if (e is AppwriteException) {
        print('Code: ${e.code}, Message: ${e.message}');
      }
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final user = await _account.get();
      final result = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _cartCollection,
        queries: [Query.equal('userId', user.$id)],
      );
      for (var doc in result.documents) {
        await _databases.deleteDocument(
          databaseId: _databaseId,
          collectionId: _cartCollection,
          documentId: doc.$id,
        );
      }
      print('DEBUG: Cart cleared for user: ${user.$id}');
    } catch (e) {
      print('CRITICAL: Error clearing cart: $e');
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final user = await _account.get();
      final result = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _cartCollection,
        queries: [Query.equal('userId', user.$id)],
      );
      print('DEBUG: Found ${result.total} items in user cart');
      return result.documents.map((doc) {
        final data = Map<String, dynamic>.from(doc.data);
        data['id'] = doc.$id;
        return serializers.deserializeWith(CartItem.serializer, data)!;
      }).toList();
    } catch (e) {
      print('CRITICAL: Error getting cart items: $e');
      return [];
    }
  }

  @override
  Stream<List<Order>> getOrders(String userId) async* {
    try {
      final result = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _ordersCollection,
        queries: [Query.equal('uid', userId)],
      );
      yield result.documents.map((doc) {
        final data = Map<String, dynamic>.from(doc.data);
        data['id'] = doc.$id;
        try {
          if (data['items'] is String) {
            data['items'] = jsonDecode(data['items']);
          }
        } catch (_) {}
        return serializers.deserializeWith(Order.serializer, data)!;
      }).toList();
    } catch (e) {
      print('Error getting orders: $e');
      yield [];
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final result = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _productsCollection,
      );
      print('DEBUG: Found ${result.total} products in Appwrite');
      return result.documents.map((doc) {
        try {
          final data = Map<String, dynamic>.from(doc.data);
          data['id'] = doc.$id;
          // Appwrite might return int for double if value is whole
          if (data['price'] is int) {
            data['price'] = (data['price'] as int).toDouble();
          }
          final product = serializers.deserializeWith(Product.serializer, data);
          if (product == null) {
            print(
              'DEBUG: Deserialization returned null for product ${doc.$id}',
            );
          }
          return product!;
        } catch (e) {
          print('DEBUG: Error deserializing product ${doc.$id}: $e');
          rethrow;
        }
      }).toList();
    } on AppwriteException catch (e) {
      print('Appwrite Error getting products: ${e.code} - ${e.message}');
      if (e.code == 401) {
        print(
          'TIP: Please check collection permissions in Appwrite Console for "$_productsCollection"',
        );
      }
      return [];
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> data) async {
    try {
      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _productsCollection,
        documentId: ID.unique(),
        data: data,
      );
    } catch (e) {
      print('Error saving product to Appwrite: $e');
      rethrow;
    }
  }

  @override
  Future<void> seedProducts() async {
    final productData = [
      {
        'title': 'Namma Filter Coffee',
        'description':
            'Pure roasted South Indian coffee blend for the perfect morning.',
        'price': 299.0,
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1675435644687-562e8042b9db?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29mZmVlfGVufDB8fDB8fHww',
        'category': 'Coffee',
      },
      {
        'title': 'Royal Silk Saree',
        'description':
            'Exquisite Kanchipuram silk with handcrafted gold zari work.',
        'price': 8500.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1618901185975-d59f7091bcfe?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2lsayUyMHNhcmVlfGVufDB8fDB8fHww',
        'category': 'Fashion',
      },
      {
        'title': 'Premium Leather Boots',
        'description':
            'Hand-stitched genuine leather boots for everlasting style.',
        'price': 4200.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1605812860427-4024433a70fd?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'category': 'Fashion',
      },
      {
        'title': 'Sony PlayStation 5',
        'description':
            'Experience lightning-fast loading and immersive 4K gaming.',
        'price': 54999.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?q=80&w=2070&auto=format&fit=crop',
        'category': 'Electronics',
      },
      {
        'title': 'AirPod Max Silver',
        'description': 'A perfect balance of exhilarating high-fidelity audio.',
        'price': 59900.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1613040809024-b4ef7ba99bc3?q=80&w=2070&auto=format&fit=crop',
        'category': 'Electronics',
      },
      {
        'title': 'Classic Chronograph',
        'description': 'Timeless design meets modern precision engineering.',
        'price': 12500.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?q=80&w=2070&auto=format&fit=crop',
        'category': 'Electronics',
      },
      {
        'title': 'Eames Lounge Chair',
        'description': 'The ultimate icon of mid-century modern luxury.',
        'price': 24000.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1519947486511-46149fa0a254?q=80&w=1974&auto=format&fit=crop',
        'category': 'Home',
      },
      {
        'title': 'Professional Drone',
        'description': 'Capture breathtaking 4K footage from the skies.',
        'price': 89000.0,
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1714618849685-89cad85746b1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZHJvbmV8ZW58MHx8MHx8fDA%3D',
        'category': 'Electronics',
      },
      {
        'title': 'Organic Honey Blend',
        'description': 'Pure, unadulterated honey sourced from hill tribes.',
        'price': 450.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1620101680144-eb3195b64514?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aG9uZXklMjBibGVuZHxlbnwwfHwwfHx8MA%3D%3D',
        'category': 'Coffee',
      },
      {
        'title': 'Cast Iron Skillet',
        'description': 'Heavy-duty cookware for restaurant-style searing.',
        'price': 2100.0,
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1716488286931-79cef654e08c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Q2FzdCUyMElyb24lMjBTa2lsbGV0fGVufDB8fDB8fHww',
        'category': 'Home',
      },
      {
        'title': 'Bamboo Table Lamp',
        'description': 'Eco-friendly lighting that adds warmth to any room.',
        'price': 1800.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?q=80&w=2070&auto=format&fit=crop',
        'category': 'Home',
      },
      {
        'title': 'Linen Summer Shirt',
        'description': 'Lightweight and breathable linen for hot climates.',
        'price': 1500.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1976&auto=format&fit=crop',
        'category': 'Fashion',
      },
    ];

    for (var product in productData) {
      await saveProduct(product);
    }
  }

  @override
  Stream<UserModel?> getUserData(String userId) async* {
    try {
      final doc = await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: _usersCollection,
        documentId: userId,
      );
      final data = Map<String, dynamic>.from(doc.data);
      data['id'] = doc.$id;
      yield serializers.deserializeWith(UserModel.serializer, data);
    } catch (e) {
      print('Error getting user data: $e');
      yield null;
    }
  }

  @override
  Future<void> saveOrder(Order order) async {
    try {
      final data =
          serializers.serializeWith(Order.serializer, order)
              as Map<String, dynamic>;
      data['items'] = jsonEncode(data['items']);
      data.remove('id');
      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _ordersCollection,
        documentId: ID.unique(),
        data: data,
      );
    } catch (e) {
      print('Error saving order: $e');
    }
  }

  @override
  Future<void> saveUserData(
    AuthUser user, {
    String? name,
    String? username,
    String? gender,
  }) async {
    try {
      final data = {
        'id': user.id,
        'email': user.email,
        'name': name,
        'username': username,
        'gender': gender,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };
      // remove nulls
      data.removeWhere((key, value) => value == null);

      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _usersCollection,
        documentId: user.id,
        data: data,
      );
    } catch (e) {
      if (e is AppwriteException && e.code == 409) {
        final data = {
          'email': user.email,
          'name': name,
          'username': username,
          'gender': gender,
        };
        data.removeWhere((key, value) => value == null);
        await _databases.updateDocument(
          databaseId: _databaseId,
          collectionId: _usersCollection,
          documentId: user.id,
          data: data,
        );
      } else {
        print('Error saving user data: $e');
      }
    }
  }

  @override
  Future<void> updateCartQuantity(String productId, int quantity) async {
    try {
      final user = await _account.get();
      final existing = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _cartCollection,
        queries: [
          Query.equal('userId', user.$id),
          Query.equal('productId', productId),
        ],
      );

      if (existing.total > 0) {
        final docId = existing.documents.first.$id;
        await _databases.updateDocument(
          databaseId: _databaseId,
          collectionId: _cartCollection,
          documentId: docId,
          data: {'quantity': quantity},
        );
        print('DEBUG: Cart quantity updated: $docId');
      }
    } catch (e) {
      print('CRITICAL: Error updating cart quantity: $e');
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    try {
      final user = await _account.get();
      final existing = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _cartCollection,
        queries: [
          Query.equal('userId', user.$id),
          Query.equal('productId', productId),
        ],
      );

      if (existing.total > 0) {
        final docId = existing.documents.first.$id;
        await _databases.deleteDocument(
          databaseId: _databaseId,
          collectionId: _cartCollection,
          documentId: docId,
        );
        print('DEBUG: Item removed from cart: $docId');
      }
    } catch (e) {
      print('CRITICAL: Error removing from cart: $e');
    }
  }
}
