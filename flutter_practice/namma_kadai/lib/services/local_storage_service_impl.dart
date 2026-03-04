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
      version: 11,
      onCreate: (db, version) async {
        await _createTables(db);
        await _seedData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('DROP TABLE IF EXISTS users');
          await db.execute('DROP TABLE IF EXISTS products');
          await db.execute('DROP TABLE IF EXISTS cart');
          await db.execute('DROP TABLE IF EXISTS orders');
          await _createTables(db);
          await _seedData(db);
        } else if (oldVersion == 4) {
          await db.execute('ALTER TABLE orders ADD COLUMN uid TEXT');
        }
        
        // Upgrade to v6/v7: Refresh products
        if (oldVersion < 7) {
          await db.execute('DROP TABLE IF EXISTS products');
          await db.execute('''
            CREATE TABLE products(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              price REAL,
              imageUrl TEXT,
              category TEXT
            )
          ''');
          await _seedData(db);
        }

        // Upgrade to v8/v9/v10/v11: Refresh URLs and apply manual updates
        if (oldVersion < 11) {
          await db.execute('DROP TABLE IF EXISTS products');
          await db.execute('''
            CREATE TABLE products(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              price REAL,
              imageUrl TEXT,
              category TEXT
            )
          ''');
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
        imageUrl TEXT,
        category TEXT
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
        uid TEXT,
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
      if (mutable['id'] != null) {
        mutable['id'] = mutable['id'].toString();
      }
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

  @override
  Map<String, dynamic> serializeOrder(Order order) {
    return serializers.serializeWith(Order.serializer, order) as Map<String, dynamic>;
  }

  @override
  Order deserializeOrder(Map<String, dynamic> map) {
    final mutable = Map<String, dynamic>.from(map);
    if (mutable['id'] != null) {
      mutable['id'] = mutable['id'].toString();
    }
    return serializers.deserializeWith(Order.serializer, mutable) as Order;
  }
}