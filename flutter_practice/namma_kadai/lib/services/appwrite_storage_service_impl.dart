import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as server;
import 'package:appwrite/models.dart' as models;
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
  final Client _client;
  final Databases _db;
  final Account _account;
  final Storage _storage;

  static const _dbId = Environment.appwriteDatabaseId;
  static const _users = Environment.appwriteUsersCollectionId;
  static const _prods = Environment.appwriteProductsCollectionId;
  static const _cart = Environment.appwriteCartCollectionId;
  static const _orders = Environment.appwriteOrdersCollectionId;
  static const _profileBucket = Environment.appwriteProfileBucketId;

  AppwriteStorageServiceImpl({required Client client})
      : _client = client,
        _db = Databases(client),
        _account = Account(client),
        _storage = Storage(client);

  Future<String> get _uid async => (await _account.get()).$id;

  Map<String, dynamic> _data(models.Document doc) =>
      Map<String, dynamic>.from(doc.data)..['id'] = doc.$id;

  Map<String, dynamic> _ser<T>(dynamic ser, T obj) =>
      serializers.serializeWith(ser, obj) as Map<String, dynamic>;

  T _deser<T>(dynamic ser, Map<String, dynamic> data) =>
      serializers.deserializeWith(ser, data) as T;

  Future<models.DocumentList> _list(String col, [List<String>? q]) =>
      _db.listDocuments(databaseId: _dbId, collectionId: col, queries: q);

  Future<models.Document> _create(String col, String id, Map data) =>
      _db.createDocument(
        databaseId: _dbId,
        collectionId: col,
        documentId: id,
        data: data,
      );

  Future<models.Document> _update(String col, String id, Map data) =>
      _db.updateDocument(
        databaseId: _dbId,
        collectionId: col,
        documentId: id,
        data: data,
      );

  @override
  Future<void> init() async {
    // Run setup in background to avoid blocking data fetch
    _setupBackend();
  }

  Future<void> _setupBackend() async {
    final apiKey = Environment.appwriteApiKey;
    if (apiKey.isEmpty) return;

    final serverClient = server.Client()
        .setEndpoint(Environment.appwritePublicEndpoint)
        .setProject(Environment.appwriteProjectId)
        .setKey(apiKey);

    final serverDb = server.Databases(serverClient);
    final serverStorage = server.Storage(serverClient);

    try {
      await _ensureBucket(serverStorage);
      await _ensureCollections(serverDb);

      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('Appwrite setup error: $e');
    }
  }

  Future<void> _ensureBucket(server.Storage storage) async {
    final bucketId = _profileBucket;
    try {
      await storage.getBucket(bucketId: bucketId);
      await storage.updateBucket(
        bucketId: bucketId,
        name: 'Profiles',
        permissions: [
          'read("any")',
          'create("any")',
          'update("any")',
          'delete("any")',
        ],
        fileSecurity: false,
        enabled: true,
      );
    } catch (e) {
      if (e is AppwriteException && (e.code == 404 || e.code == 401)) {
        await storage.createBucket(
          bucketId: bucketId,
          name: 'Profiles',
          permissions: [
            'read("any")',
            'create("any")',
            'update("any")',
            'delete("any")',
          ],
          fileSecurity: false,
          enabled: true,
        );
      }
    }
  }

  Future<void> _ensureCollections(server.Databases db) async {
    final schema = {
      _users: {
        'name': 'Users',
        'attr': [
          {'key': 'id', 'type': 'string', 'size': 255},
          {'key': 'email', 'type': 'string', 'size': 255},
          {'key': 'name', 'type': 'string', 'size': 255},
          {'key': 'gender', 'type': 'string', 'size': 50},
          {'key': 'profileImageUrl', 'type': 'string', 'size': 1000},
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

    for (final entry in schema.entries) {
      final colId = entry.key;
      final config = entry.value;

      try {
        await db.getCollection(databaseId: _dbId, collectionId: colId);
        await db.updateCollection(
          databaseId: _dbId,
          collectionId: colId,
          name: config['name'] as String,
          permissions: [
            'read("any")',
            'create("any")',
            'update("any")',
            'delete("any")',
          ],
          documentSecurity: false,
          enabled: true,
        );
      } catch (e) {
        if (e is AppwriteException && e.code == 404) {
          await db.createCollection(
            databaseId: _dbId,
            collectionId: colId,
            name: config['name'] as String,
            permissions: [
              'read("any")',
              'create("any")',
              'update("any")',
              'delete("any")',
            ],
            documentSecurity: false,
            enabled: true,
          );
        }
      }

      // Add attributes
      final attrs = config['attr'] as List<Map<String, dynamic>>;
      for (final a in attrs) {
        try {
          final key = a['key'] as String;
          final type = a['type'] as String;

          if (type == 'string') {
            await db.createStringAttribute(
              databaseId: _dbId,
              collectionId: colId,
              key: key,
              size: a['size'] as int,
              xrequired: false,
            );
          } else if (type == 'integer') {
            await db.createIntegerAttribute(
              databaseId: _dbId,
              collectionId: colId,
              key: key,
              xrequired: false,
            );
          } else if (type == 'float') {
            await db.createFloatAttribute(
              databaseId: _dbId,
              collectionId: colId,
              key: key,
              xrequired: false,
            );
          }
        } catch (_) {}
      }
    }
  }

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
      if (res.total > 0) {
        await _update(_cart, res.documents.first.$id, data);
      } else {
        await _create(_cart, ID.unique(), data);
      }
    } catch (_) {}
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
    } catch (_) {}
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
      final res = await _list(_cart, [
        Query.equal('userId', await _uid),
        Query.equal('productId', pid),
      ]);
      if (res.total > 0)
        await _update(_cart, res.documents.first.$id, {'quantity': q});
    } catch (_) {}
  }

  @override
  Future<void> removeFromCart(String pid) async {
    try {
      final res = await _list(_cart, [
        Query.equal('userId', await _uid),
        Query.equal('productId', pid),
      ]);
      if (res.total > 0)
        await _db.deleteDocument(
          databaseId: _dbId,
          collectionId: _cart,
          documentId: res.documents.first.$id,
        );
    } catch (_) {}
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
    try {
      await _create(_prods, ID.unique(), data);
    } catch (_) {}
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
  Future<void> saveUserData(
    AuthUser u, {
    String? name,
    String? gender,
    String? profileImageUrl,
  }) async {
    final data = {
      'id': u.id,
      'email': u.email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
    try {
      await _create(_users, u.id, data);
    } catch (e) {
      if (e is AppwriteException && e.code == 409) {
        await _update(
          _users,
          u.id,
          data
            ..remove('id')
            ..remove('createdAt'),
        );
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
      final data = _ser(Order.serializer, o);
      final id = ID.unique();
      data['id'] = id;
      data['items'] = jsonEncode(data['items']);
      data['dateTime'] = o.dateTime.toIso8601String();
      await _create(_orders, id, data);
    } catch (_) {}
  }

  @override
  Future<String?> uploadProfilePhotoBytes(
    String userId,
    List<int> bytes,
    String fileName,
  ) async {
    try {
      final file = await _storage.createFile(
        bucketId: _profileBucket,
        fileId: userId,
        file: InputFile.fromBytes(bytes: bytes, filename: fileName),
      );
      final url =
          '${Environment.appwritePublicEndpoint}/storage/buckets/$_profileBucket/files/${file.$id}/view?project=${Environment.appwriteProjectId}';
      final currentUser = await _account.get();
      await saveUserData(
        AuthUser(id: currentUser.$id, email: currentUser.email),
        profileImageUrl: url,
      );
      return url;
    } catch (e) {
      if (e is AppwriteException && e.code == 409) {
        try {
          await _storage.deleteFile(bucketId: _profileBucket, fileId: userId);
          return await uploadProfilePhotoBytes(userId, bytes, fileName);
        } catch (_) {}
      }
      return null;
    }
  }
}
