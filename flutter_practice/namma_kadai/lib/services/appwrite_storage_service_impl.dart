import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:http/http.dart' as http;
import '../core/services/auth_service.dart';
import '../core/services/storage_service.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/user_model.dart';
import '../model/serializers.dart';
import '../config/environment.dart';
import '../data/product_seed_data.dart';
import 'dart:convert';

class AppwriteStorageServiceImpl implements StorageService {
  final Databases _db;
  final Account _account;

  static const _dbId = Environment.appwriteDatabaseId;
  static const _users = Environment.appwriteUsersCollectionId;
  static const _prods = Environment.appwriteProductsCollectionId;
  static const _cart = Environment.appwriteCartCollectionId;
  static const _orders = Environment.appwriteOrdersCollectionId;

  AppwriteStorageServiceImpl({Databases? databases, Account? account})
      : _db = databases ??
            Databases(
              Client()
                  .setEndpoint(Environment.appwritePublicEndpoint)
                  .setProject(Environment.appwriteProjectId)
                  .setSelfSigned(status: true),
            ),
        _account = account ??
            Account(
              Client()
                  .setEndpoint(Environment.appwritePublicEndpoint)
                  .setProject(Environment.appwriteProjectId)
                  .setSelfSigned(status: true),
            );

  Future<String> get _uid async => (await _account.get()).$id;

  Future<List<String>> _p(String uid) async => [
        Permission.read(Role.user(uid)),
        Permission.update(Role.user(uid)),
        Permission.delete(Role.user(uid)),
      ];

  Map<String, dynamic> _data(models.Document doc) =>
      Map<String, dynamic>.from(doc.data)..['id'] = doc.$id;

  Map<String, dynamic> _ser<T>(dynamic ser, T obj) =>
      serializers.serializeWith(ser, obj) as Map<String, dynamic>;

  T _deser<T>(dynamic ser, Map<String, dynamic> data) =>
      serializers.deserializeWith(ser, data) as T;

  Future<models.DocumentList> _list(String col, [List<String>? q]) =>
      _db.listDocuments(databaseId: _dbId, collectionId: col, queries: q);

  Future<models.Document> _create(
    String col,
    String id,
    Map data, [
    List<String>? perms,
  ]) =>
      _db.createDocument(
        databaseId: _dbId,
        collectionId: col,
        documentId: id,
        data: data,
        permissions: perms,
      );

  Future<models.Document> _update(
    String col,
    String id,
    Map data, [
    List<String>? perms,
  ]) =>
      _db.updateDocument(
        databaseId: _dbId,
        collectionId: col,
        documentId: id,
        data: data,
        permissions: perms,
      );

  // ─── Setup ──────────────────────────────────────────────────────────────────

  @override
  Future<void> init() async {
    try {
      await _setupBackendViaRest();
    } catch (e) {
      print('CRITICAL: Appwrite Setup Error: $e');
    }
  }

  Future<void> _setupBackendViaRest() async {
    final apiKey = Environment.appwriteApiKey;
    if (apiKey.isEmpty) return;

    final base = Environment.appwritePublicEndpoint;
    final headers = {
      'X-Appwrite-Project': Environment.appwriteProjectId,
      'X-Appwrite-Key': apiKey,
      'Content-Type': 'application/json',
    };

    final schema = {
      _users: {
        'name': 'Users',
        'attr': [
          {'key': 'id', 'type': 'string', 'size': 255},
          {'key': 'email', 'type': 'string', 'size': 255},
          {'key': 'name', 'type': 'string', 'size': 255},
          {'key': 'gender', 'type': 'string', 'size': 50},
          {'key': 'createdAt', 'type': 'integer'},
        ],
      },
      _prods: {
        'name': 'Products',
        'attr': [
          {'key': 'id', 'type': 'string', 'size': 255},
          {'key': 'title', 'type': 'string', 'size': 255},
          {'key': 'price', 'type': 'float'},
          {'key': 'imageUrl', 'type': 'string', 'size': 1000},
          {'key': 'category', 'type': 'string', 'size': 100},
        ],
      },
      _cart: {
        'name': 'Cart',
        'attr': [
          {'key': 'id', 'type': 'string', 'size': 255},
          {'key': 'userId', 'type': 'string', 'size': 255},
          {'key': 'productId', 'type': 'string', 'size': 255},
          {'key': 'quantity', 'type': 'integer'},
        ],
      },
      _orders: {
        'name': 'Orders',
        'attr': [
          {'key': 'id', 'type': 'string', 'size': 255},
          {'key': 'uid', 'type': 'string', 'size': 255},
          {'key': 'items', 'type': 'string', 'size': 65000},
          {'key': 'totalAmount', 'type': 'float'},
          {'key': 'dateTime', 'type': 'string', 'size': 100},
        ],
      },
    };

    final client = http.Client();
    try {
      for (final entry in schema.entries) {
        final colId = entry.key;
        final colName = entry.value['name'] as String;
        final attrs = entry.value['attr'] as List;
        final colUrl = Uri.parse('$base/databases/$_dbId/collections/$colId');

        final config = {
          'name': colName,
          'permissions': [
            'read("any")',
            'create("users")',
            'update("users")',
            'delete("users")',
          ],
          'documentSecurity': true,
        };

        final res = await client.get(colUrl, headers: headers);
        if (res.statusCode == 404) {
          await client.post(
            Uri.parse('$base/databases/$_dbId/collections'),
            headers: headers,
            body: jsonEncode({'collectionId': colId, ...config}),
          );
          print(
            'DEBUG: Created collection $colId with Document Security ENABLED.',
          );
        } else {
          final cur = jsonDecode(res.body);
          if (cur['documentSecurity'] == false) {
            final up = await client.put(
              colUrl,
              headers: headers,
              body: jsonEncode(config),
            );
            print(
              'DEBUG: Updated collection $colId - Status: ${up.statusCode}. Response: ${up.body}',
            );
          }
        }

        for (final a in attrs.cast<Map<String, dynamic>>()) {
          await client.post(
            Uri.parse(
              '$base/databases/$_dbId/collections/$colId/attributes/${a['type']}',
            ),
            headers: headers,
            body: jsonEncode({...a, 'required': false}),
          );
        }
      }
      await Future.delayed(const Duration(seconds: 1));
    } finally {
      client.close();
    }
  }

  // ─── Operations ─────────────────────────────────────────────────────────────

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final uid = await _uid;
      final data = _ser(CartItem.serializer, item)
        ..['userId'] = uid
        ..remove('id');
      final res = await _list(_cart, [
        Query.equal('userId', uid),
        Query.equal('productId', item.productId),
      ]);
      final perms = await _p(uid);
      if (res.total > 0) {
        await _update(_cart, res.documents.first.$id, data, perms);
      } else {
        await _create(_cart, ID.unique(), data, perms);
      }
    } catch (e) {
      if (e is AppwriteException &&
          e.message?.contains('any, guests') == true) {
        print(
          'WARNING: Document Security is not enabled on Cart. Retrying without user-specific permissions.',
        );
        final uid = await _uid;
        final data = _ser(CartItem.serializer, item)
          ..['userId'] = uid
          ..remove('id');
        await _create(
          _cart,
          ID.unique(),
          data,
        );
      } else {
        print('CRITICAL: Error adding to cart: $e');
      }
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final res = await _list(_cart, [Query.equal('userId', await _uid)]);
      for (final doc in res.documents) {
        try {
          await _db.deleteDocument(
            databaseId: _dbId,
            collectionId: _cart,
            documentId: doc.$id,
          );
        } catch (_) {}
      }
    } catch (e) {
      print('CRITICAL: Error clearing cart: $e');
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final res = await _list(_cart, [Query.equal('userId', await _uid)]);
      return res.documents
          .map((d) => _deser<CartItem>(CartItem.serializer, _data(d)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> updateCartQuantity(String pid, int q) async {
    try {
      final uid = await _uid;
      final res = await _list(_cart, [
        Query.equal('userId', uid),
        Query.equal('productId', pid),
      ]);
      if (res.total > 0)
        await _update(
            _cart,
            res.documents.first.$id,
            {
              'quantity': q,
            },
            await _p(uid));
    } catch (e) {
      print('CRITICAL: Error updating cart quantity: $e');
    }
  }

  @override
  Future<void> removeFromCart(String pid) async {
    try {
      final uid = await _uid;
      final res = await _list(_cart, [
        Query.equal('userId', uid),
        Query.equal('productId', pid),
      ]);
      if (res.total > 0)
        await _db.deleteDocument(
          databaseId: _dbId,
          collectionId: _cart,
          documentId: res.documents.first.$id,
        );
    } catch (e) {
      print('CRITICAL: Error removing from cart: $e');
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final res = await _list(_prods);
      return res.documents.map((d) {
        final map = _data(d);
        if (map['price'] is int)
          map['price'] = (map['price'] as int).toDouble();
        return _deser<Product>(Product.serializer, map);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> data) async {
    await _create(_prods, ID.unique(), data);
  }

  @override
  Future<void> seedProducts() async {
    for (final p in kProductSeedData)
      await saveProduct(Map<String, dynamic>.from(p));
  }

  @override
  Stream<UserModel?> getUserData(String id) async* {
    try {
      final doc = await _db.getDocument(
        databaseId: _dbId,
        collectionId: _users,
        documentId: id,
      );
      yield _deser<UserModel>(UserModel.serializer, _data(doc));
    } catch (e) {
      yield null;
    }
  }

  @override
  Future<void> saveUserData(AuthUser u, {String? name, String? gender}) async {
    final data = {
      'id': u.id,
      'email': u.email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
    try {
      await _create(_users, u.id, data, await _p(u.id));
    } catch (e) {
      if (e is AppwriteException && e.code == 409) {
        await _update(
          _users,
          u.id,
          data
            ..remove('id')
            ..remove('createdAt'),
          await _p(u.id),
        );
      } else {
        print('CRITICAL: Error saving user data: $e');
        if (e.toString().contains('any, guests')) {
          await _create(_users, u.id, data); // Fallback
        }
      }
    }
  }

  @override
  Stream<List<Order>> getOrders(String uid) async* {
    try {
      final res = await _list(_orders, [Query.equal('uid', uid)]);
      yield res.documents.map((d) {
        final map = _data(d);
        if (map['items'] is String) map['items'] = jsonDecode(map['items']);
        return _deser<Order>(Order.serializer, map);
      }).toList();
    } catch (e) {
      yield [];
    }
  }

  @override
  Future<void> saveOrder(Order o) async {
    try {
      final uid = await _uid;
      final data = _ser(Order.serializer, o);
      final id = ID.unique();
      data['id'] = id;
      data['items'] = jsonEncode(data['items']);
      data['dateTime'] = o.dateTime.toIso8601String();
      await _create(_orders, id, data, await _p(uid));
    } catch (e) {
      print('CRITICAL: Error saving order: $e');
      if (e.toString().contains('any, guests')) {
        await saveOrderFallback(o);
      }
    }
  }

  Future<void> saveOrderFallback(Order o) async {
    try {
      final data = _ser(Order.serializer, o);
      final id = ID.unique();
      data['id'] = id;
      data['items'] = jsonEncode(data['items']);
      data['dateTime'] = o.dateTime.toIso8601String();
      await _create(_orders, id, data); // No permissions
    } catch (e) {
      print("CRITICAL: Error saving order fallback: $e");
    }
  }
}
