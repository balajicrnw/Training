import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../core/services/local_storage_service.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../model/serializers.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  Database? _database;

  @override
  Future<void> init() async {
    if (_database != null) return;

    String path = join(await getDatabasesPath(), 'namma_kadai.db');
    _database = await openDatabase(
      path,
      version: 4,
      onUpgrade: (db, oldVersion, newVersion) async {
        print('Upgrading database from $oldVersion to $newVersion');
        if (oldVersion < 4) {
          await db.execute('DROP TABLE IF EXISTS products');
          await db.execute('DROP TABLE IF EXISTS cart');
          await db.execute('DROP TABLE IF EXISTS orders');
          await _createTables(db);
          await _seedData(db);
        }
      },
      onCreate: (db, version) async {
        print('Creating database version $version');
        await _createTables(db);
        await _seedData(db);
      },
    );
    print('SQLite Database opened at: $path');
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
    final List<Map<String, dynamic>> productData = [
      {
        'title': 'Namma Filter Coffee',
        'description': 'Authentic South Indian filter coffee powder.',
        'price': 250.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=2070&auto=format&fit=crop',
      },
      {
        'title': 'Traditional Silk Saree',
        'description': 'Handwoven Kanchipuram silk saree with zari border.',
        'price': 5500.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1610030469983-98e550d6193c?q=80&w=1974&auto=format&fit=crop',
      },
      {
        'title': 'Brass Pooja Lamp',
        'description': 'Elegant brass lamp for your daily prayers.',
        'price': 850.0,
        'imageUrl': 'https://m.media-amazon.com/images/I/61ko3sPvQaL._SX679_.jpg',
      },
      {
        'title': 'Organic Palm Jaggery',
        'description': 'Healthy and natural palm jaggery from local farms.',
        'price': 180.0,
        'imageUrl':
            'https://m.media-amazon.com/images/I/31kEZjWsdfS.jpg',
      },
      {
        'title': 'Sony PlayStation 4 (PS4)',
        'description': 'Popular gaming console with immersive graphics and exclusive games.',
        'price': 29999.0,
        'imageUrl':
            'https://i.dr.com.tr/cache/500x400-0/originals/0001793012001-1.jpg',
      },
      {
        'title': 'Nike Running Shoes',
        'description': 'Lightweight and comfortable running shoes for daily workouts.',
        'price': 4599.0,
        'imageUrl':
            'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcS_uHQa0Z4Y-md9zJjoloxnqHC_28PTyzgYyyYkZ5-4aZX6aFGYusIrsUqwK89qH7RZTMRv8nCGnRoVSy2Ge5IjupZuemCz',
      },
      {
        'title': 'Stainless Steel Water Bottle',
        'description': 'Insulated bottle that keeps drinks hot or cold for hours.',
        'price': 799.0,
        'imageUrl':
            'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQJB3TVFB-nO7kANOi_vWSTydoUIhIXX6gCO203lBwuRP9xiQseo1jEzod0YAxjjF0usmukai5v2fGKyvepHNKTThv3elBwTOBRzXMt44dfLdyUMBiqOrtkC_w',
      },
      {
        'title': 'Samsung 32-inch Smart TV',
        'description': 'HD smart TV with streaming apps and vibrant display.',
        'price': 18999.0,
        'imageUrl':
              'https://m.media-amazon.com/images/I/71XA+N8Xj1L._SL1500_.jpg',
      },
      {
        'title': 'Cooking Non-Stick Pan',
        'description': 'Durable non-stick frying pan suitable for everyday cooking.',
        'price': 999.0,
        'imageUrl':
            'https://m.media-amazon.com/images/I/41VSFd1bIXL._SY300_SX300_QL70_FMwebp_.jpg',
      },
      {
        'title': 'Casual Backpack',
        'description': 'Spacious backpack ideal for travel, college, and office use.',
        'price': 1299.0,
        'imageUrl':
            'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQK0EhDtlgzv8oBCQjGRiOJKverqFrhzwZpUflE1oPLTL3-lL2uN95yVU_10C_ZoDneV-zjQNMHFOXYVKRAxY040vrbwB3t1kif-Xv7eblpxqumeFAdHg2dCl40ZzgRu1d301T3vA&usqp=CAc',
      },
    ];

    for (var data in productData) {
      // Validate with serializer and insert
      try {
        final product = serializers.deserializeWith(Product.serializer, data) as Product;
        final json = serializers.serializeWith(Product.serializer, product) as Map<String, dynamic>;
        await db.insert('products', json);
      } catch (e) {
        print('Error seeding product: $e');
      }
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    final List<Map<String, dynamic>> maps = await _database!.query('products');
    return maps
        .map((map) =>
            serializers.deserializeWith(Product.serializer, map) as Product)
        .toList();
  }

  @override
  Future<void> insertProduct(Product product) async {
    final json = serializers.serializeWith(Product.serializer, product)
        as Map<String, dynamic>;
    await _database!.insert('products', json,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await _database!.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final List<Map<String, dynamic>> maps = await _database!.query('cart');
    return maps
        .map((map) =>
            serializers.deserializeWith(CartItem.serializer, map) as CartItem)
        .toList();
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final List<Map<String, dynamic>> existing = await _database!.query(
      'cart',
      where: 'productId = ?',
      whereArgs: [item.productId],
    );

    if (existing.isNotEmpty) {
      final currentQty = existing.first['quantity'] as int;
      await updateCartQuantity(item.productId, currentQty + item.quantity);
    } else {
      final json = serializers.serializeWith(CartItem.serializer, item)
          as Map<String, dynamic>;
      await _database!.insert('cart', json,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> updateCartQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await _database!.update(
        'cart',
        {'quantity': quantity},
        where: 'productId = ?',
        whereArgs: [productId],
      );
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await _database!
        .delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  @override
  Future<void> clearCart() async {
    await _database!.delete('cart');
  }

  @override
  Future<List<Order>> getOrders() async {
    try {
      final List<Map<String, dynamic>> maps =
          await _database!.query('orders', orderBy: 'id DESC');
      print('Retrieved ${maps.length} orders from DB');
      return maps.map((map) {
        try {
          final mutableMap = Map<String, dynamic>.from(map);
          mutableMap['items'] = jsonDecode(mutableMap['items'] as String);
          return serializers.deserializeWith(Order.serializer, mutableMap) as Order;
        } catch (e) {
          print('Error deserializing order ${map['id']}: $e');
          rethrow;
        }
      }).toList();
    } catch (e) {
      print('Error getting orders: $e');
      return [];
    }
  }

  @override
  Future<void> placeOrder(Order order) async {
    try {
      final json = serializers.serializeWith(Order.serializer, order)
          as Map<String, dynamic>;
      final mutableJson = Map<String, dynamic>.from(json);
      mutableJson['items'] = jsonEncode(mutableJson['items']);
      
      print('Placing order with data: $mutableJson');
      final resultId = await _database!.insert('orders', mutableJson);
      print('Order placed successfully with ID: $resultId');
      
      await clearCart();
    } catch (e) {
      print('Error placing order: $e');
      rethrow;
    }
  }
}
