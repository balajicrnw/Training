import 'dart:async';
import 'package:namma_kadai_shared/namma_kadai_shared.dart';
import 'package:firedart/firedart.dart';

class ApiImpl implements StorageService {
  String? currentUserId;

  @override
  Future<void> init() async {
    Firestore.initialize('namma-kadai-d7220');
    FirebaseAuth.initialize(
      'AIzaSyD-037x_qckmCuO4UFee6L9inf3MyjzYjA',
      VolatileStore(),
    );
    await seedProducts();
  }

  Future<AuthUser?> signIn(String email, String password) async {
    try {
      final user = await FirebaseAuth.instance.signIn(email, password);
      return AuthUser(
        (b) => b
          ..id = user.id
          ..email = email,
      );
    } catch (e) {
      return null;
    }
  }

  Future<AuthUser?> signUp(
    String email,
    String password, {
    String? name,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signUp(email, password);
      final authUser = AuthUser(
        (b) => b
          ..id = user.id
          ..email = email,
      );

      final userModel = UserModel(
        (b) => b
          ..id = user.id
          ..email = email
          ..name = name
          ..createdAt = DateTime.now(),
      );

      await Firestore.instance
          .collection('users')
          .document(user.id)
          .set(
            serializers.serializeWith(UserModel.serializer, userModel)
                as Map<String, dynamic>,
          );

      return authUser;
    } catch (e) {
      throw Exception('email-already-in-use');
    }
  }

  @override
  Future<void> seedProducts() async {
    final products = await Firestore.instance.collection('products').get();
    if (products.isNotEmpty) return;

    int idCounter = 1;
    for (final data in kProductSeedData) {
      final mutableData = Map<String, dynamic>.from(data);
      mutableData['id'] = 'seeded_prod_${idCounter++}';

      final product = serializers.deserializeWith(
        Product.serializer,
        mutableData,
      );
      if (product != null) {
        await Firestore.instance
            .collection('products')
            .document(product.id!)
            .set(
              serializers.serializeWith(Product.serializer, product)
                  as Map<String, dynamic>,
            );
      }
    }
  }

  @override
  Future<void> saveUserData(
    AuthUser user, {
    String? name,
    String? gender,
    String? profileImageUrl,
  }) async {
    final doc = await Firestore.instance
        .collection('users')
        .document(user.id)
        .get()
        .catchError((_) => throw Exception("Doc not found"));

    Map<String, dynamic> existing = {};
    if (doc != null) {
      existing = doc.map;
    }

    final newUser = UserModel(
      (b) => b
        ..id = user.id
        ..email = user.email
        ..name = name ?? existing['name']
        ..gender = gender ?? existing['gender']
        ..profileImageUrl = profileImageUrl ?? existing['profileImageUrl']
        ..createdAt = existing['createdAt'] != null
            ? DateTime.parse(existing['createdAt'].toString())
            : DateTime.now(),
    );

    await Firestore.instance
        .collection('users')
        .document(user.id)
        .set(
          serializers.serializeWith(UserModel.serializer, newUser)
              as Map<String, dynamic>,
        );
  }

  @override
  Stream<UserModel?> getUserData(String userId) async* {
    try {
      final stream = Firestore.instance
          .collection('users')
          .document(userId)
          .stream;
      await for (final doc in stream) {
        if (doc != null) {
          final data = doc.map;
          data['id'] = doc.id;
          yield serializers.deserializeWith(UserModel.serializer, data);
        } else {
          yield null;
        }
      }
    } catch (_) {
      yield null;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    final docs = await Firestore.instance.collection('products').get();
    return docs.map((d) {
      final data = d.map;
      data['id'] = d.id;
      return serializers.deserializeWith(Product.serializer, data)!;
    }).toList();
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> data) async {
    final product = serializers.deserializeWith(Product.serializer, data);
    if (product != null) {
      final id = product.id ?? 'prod_${DateTime.now().millisecondsSinceEpoch}';
      final serialized =
          serializers.serializeWith(Product.serializer, product)
              as Map<String, dynamic>;
      serialized['id'] = id;
      await Firestore.instance
          .collection('products')
          .document(id)
          .set(serialized);
    }
  }

  Future<void> insertProduct(Product product) async {
    final id = product.id ?? 'prod_${DateTime.now().millisecondsSinceEpoch}';
    final serialized =
        serializers.serializeWith(Product.serializer, product)
            as Map<String, dynamic>;
    serialized['id'] = id;
    await Firestore.instance
        .collection('products')
        .document(id)
        .set(serialized);
  }

  Future<void> deleteProduct(String id) async {
    await Firestore.instance.collection('products').document(id).delete();
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    if (currentUserId == null) return [];
    try {
      final docs = await Firestore.instance
          .collection('users')
          .document(currentUserId!)
          .collection('cart')
          .get();
      return docs.map((d) {
        final data = d.map;
        data['id'] = d.id;
        return serializers.deserializeWith(CartItem.serializer, data)!;
      }).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    if (currentUserId == null) return;

    final collection = Firestore.instance
        .collection('users')
        .document(currentUserId!)
        .collection('cart');

    try {
      final doc = await collection.document(item.productId).get();
      final existingData = doc.map;
      final existing = serializers.deserializeWith(
        CartItem.serializer,
        existingData,
      )!;

      final updated = existing.rebuild(
        (b) => b..quantity = existing.quantity + item.quantity,
      );
      await collection
          .document(item.productId)
          .update(
            serializers.serializeWith(CartItem.serializer, updated)
                as Map<String, dynamic>,
          );
    } catch (_) {
      await collection
          .document(item.productId)
          .set(
            serializers.serializeWith(CartItem.serializer, item)
                as Map<String, dynamic>,
          );
    }
  }

  @override
  Future<void> updateCartQuantity(String productId, int quantity) async {
    if (currentUserId == null) return;
    final collection = Firestore.instance
        .collection('users')
        .document(currentUserId!)
        .collection('cart');

    if (quantity <= 0) {
      await collection.document(productId).delete().catchError((_) {});
    } else {
      try {
        final doc = await collection.document(productId).get();
        final existingData = doc.map;
        final existing = serializers.deserializeWith(
          CartItem.serializer,
          existingData,
        )!;

        final updated = existing.rebuild((b) => b..quantity = quantity);
        await collection
            .document(productId)
            .update(
              serializers.serializeWith(CartItem.serializer, updated)
                  as Map<String, dynamic>,
            );
      } catch (_) {}
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    if (currentUserId == null) return;
    await Firestore.instance
        .collection('users')
        .document(currentUserId!)
        .collection('cart')
        .document(productId)
        .delete()
        .catchError((_) {});
  }

  @override
  Future<void> clearCart() async {
    if (currentUserId == null) return;
    try {
      final collection = Firestore.instance
          .collection('users')
          .document(currentUserId!)
          .collection('cart');
      final docs = await collection.get();
      for (final doc in docs) {
        await collection.document(doc.id).delete();
      }
    } catch (_) {}
  }

  @override
  Future<void> saveOrder(Order order) async {
    if (order.uid == null) return;
    final collection = Firestore.instance
        .collection('users')
        .document(order.uid!)
        .collection('orders');
    final orderWithDate = order.rebuild((b) => b..dateTime = DateTime.now());
    await collection.add(
      serializers.serializeWith(Order.serializer, orderWithDate)
          as Map<String, dynamic>,
    );
  }

  @override
  Stream<List<Order>> getOrders(String userId) async* {
    try {
      final docs = await Firestore.instance
          .collection('users')
          .document(userId)
          .collection('orders')
          .get();
      yield docs.map((d) {
        final data = Map<String, dynamic>.from(d.map);
        data['id'] = d.id;
        return serializers.deserializeWith(Order.serializer, data)!;
      }).toList();
    } catch (_) {
      yield [];
    }
  }

  @override
  Future<String?> uploadProfilePhotoBytes(
    String userId,
    List<int> bytes,
    String fileName,
  ) async {
    return 'http://localhost:8082/mock-profile.png';
  }
}
