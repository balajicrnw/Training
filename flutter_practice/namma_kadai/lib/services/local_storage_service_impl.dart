import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../core/services/local_storage_service.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../model/serializers.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  
  static final LocalStorageServiceImpl _instance =
      LocalStorageServiceImpl._internal();

  factory LocalStorageServiceImpl() {
    return _instance;
  }

  LocalStorageServiceImpl._internal();

  Database? _database;


  @override
  Future<void> init() async {
    if (_database != null) return;

    final path = join(await getDatabasesPath(), 'namma_kadai.db');

    _database = await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await _createTables(db);
        await _seedData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('DROP TABLE IF EXISTS products');
          await db.execute('DROP TABLE IF EXISTS cart');
          await db.execute('DROP TABLE IF EXISTS orders');
          await _createTables(db);
          await _seedData(db);
        }
      },
    );
  }

  Database get db {
    if (_database == null) {
      throw Exception("Database not initialized. Call init() first.");
    }
    return _database!;
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        price REAL,
        imageUrl TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        title TEXT,
        price REAL,
        imageUrl TEXT,
        quantity INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        items TEXT,
        totalAmount REAL,
        dateTime INTEGER
      )
    ''');
  }

  Future<void> _seedData(Database db) async {
    final productData = [
      {
        'title': 'Namma Filter Coffee',
        'description': 'Authentic South Indian filter coffee powder.',
        'price': 250.0,
        'imageUrl': 'https://example.com/coffee.jpg',
      },
    ];

    for (var data in productData) {
      final product =
          serializers.deserializeWith(Product.serializer, data) as Product;

      final json = serializers.serializeWith(Product.serializer, product)
          as Map<String, dynamic>;

      await db.insert('products', json);
    }
  }

  // ---------------- PRODUCTS ----------------

  @override
  Future<List<Product>> getProducts() async {
    final maps = await db.query('products');
    return maps
        .map((map) =>
            serializers.deserializeWith(Product.serializer, map) as Product)
        .toList();
  }

  @override
  Future<void> insertProduct(Product product) async {
    final json = serializers.serializeWith(Product.serializer, product)
        as Map<String, dynamic>;

    await db.insert(
      'products',
      json,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

 

  @override
  Future<List<CartItem>> getCartItems() async {
    final maps = await db.query('cart');
    return maps
        .map((map) =>
            serializers.deserializeWith(CartItem.serializer, map) as CartItem)
        .toList();
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final json =
        serializers.serializeWith(CartItem.serializer, item) as Map<String, dynamic>;

    await db.insert(
      'cart',
      json,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateCartQuantity(int productId, int quantity) async {
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  @override
  Future<void> clearCart() async {
    await db.delete('cart');
  }



  @override
  Future<List<Order>> getOrders() async {
    final maps = await db.query('orders', orderBy: 'id DESC');

    return maps.map((map) {
      final mutable = Map<String, dynamic>.from(map);
      mutable['items'] = jsonDecode(mutable['items']);
      return serializers.deserializeWith(Order.serializer, mutable) as Order;
    }).toList();
  }

  @override
  Future<void> placeOrder(Order order) async {
    final json =
        serializers.serializeWith(Order.serializer, order) as Map<String, dynamic>;

    final mutable = Map<String, dynamic>.from(json);
    mutable['items'] = jsonEncode(mutable['items']);

    await db.insert('orders', mutable);
    await clearCart();
  }
}