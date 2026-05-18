import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart';

final serverpodServiceProvider = Provider((ref) => ServerpodService());

class ServerpodService implements StorageService {
  final String baseUrl = 'http://localhost:8082';

  String? currentUserId;

  @override
  Future<void> init() async {
    await seedProducts();
  }

  @override
  Future<void> seedProducts() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/seedProducts'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200)
        throw Exception('Failed to seed products');
    } catch (e) {
      print('Error calling seedProducts: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(
    AuthUser user, {
    String? name,
    String? gender,
    String? profileImageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/saveUserData'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': user.id,
          'email': user.email,
          'name': name,
          'gender': gender,
          'profileImageUrl': profileImageUrl,
        }),
      );
      if (response.statusCode != 200)
        throw Exception('Failed to save user data');
    } catch (e) {
      print('Error calling saveUserData: $e');
      rethrow;
    }
  }

  @override
  Stream<UserModel?> getUserData(String userId) {
    return Stream.fromFuture(http
        .get(Uri.parse('$baseUrl/getUserData?userId=$userId'))
        .then((response) {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return serializers.deserializeWith(UserModel.serializer, data);
      }
      return null;
    }));
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getProducts'));
      if (response.statusCode != 200) throw Exception('Failed to get products');
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) =>
              serializers.deserializeWith(Product.serializer, item) as Product)
          .toList();
    } catch (e) {
      print('Error calling getProducts: $e');
      return [];
    }
  }

  @override
  Future<void> saveProduct(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/createProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode != 200) throw Exception('Failed to save product');
    } catch (e) {
      print('Error calling saveProduct: $e');
      rethrow;
    }
  }

  Future<void> insertProduct(Product product) async {
    final data = serializers.serializeWith(Product.serializer, product)
        as Map<String, dynamic>;
    await saveProduct(data);
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/deleteProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      if (response.statusCode != 200)
        throw Exception('Failed to delete product');
    } catch (e) {
      print('Error calling deleteProduct: $e');
      rethrow;
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final userId = currentUserId ?? 'mock_user';
      final response =
          await http.get(Uri.parse('$baseUrl/getCartItems?userId=$userId'));
      if (response.statusCode != 200)
        throw Exception('Failed to get cart items');
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => serializers.deserializeWith(CartItem.serializer, item)
              as CartItem)
          .toList();
    } catch (e) {
      print('Error calling getCartItems: $e');
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final userId = currentUserId ?? 'mock_user';
      final data = serializers.serializeWith(CartItem.serializer, item)
          as Map<String, dynamic>;
      final response = await http.post(
        Uri.parse('$baseUrl/addToCart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({...data, 'userId': userId}),
      );
      if (response.statusCode != 200) throw Exception('Failed to add to cart');
    } catch (e) {
      print('Error calling addToCart: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCartQuantity(String productId, int quantity) async {
    try {
      final userId = currentUserId ?? 'mock_user';
      final response = await http.post(
        Uri.parse('$baseUrl/updateCartQuantity'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'productId': productId, 'quantity': quantity, 'userId': userId}),
      );
      if (response.statusCode != 200)
        throw Exception('Failed to update cart quantity');
    } catch (e) {
      print('Error calling updateCartQuantity: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    try {
      final userId = currentUserId ?? 'mock_user';
      final response = await http.post(
        Uri.parse('$baseUrl/removeFromCart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'productId': productId, 'userId': userId}),
      );
      if (response.statusCode != 200)
        throw Exception('Failed to remove from cart');
    } catch (e) {
      print('Error calling removeFromCart: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final userId = currentUserId ?? 'mock_user';
      final response = await http.post(
        Uri.parse('$baseUrl/clearCart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );
      if (response.statusCode != 200) throw Exception('Failed to clear cart');
    } catch (e) {
      print('Error calling clearCart: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveOrder(Order order) async {
    try {
      final data = serializers.serializeWith(Order.serializer, order)
          as Map<String, dynamic>;
      final response = await http.post(
        Uri.parse('$baseUrl/saveOrder'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode != 200) throw Exception('Failed to save order');
    } catch (e) {
      print('Error calling saveOrder: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Order>> getOrders(String userId) {
    return Stream.fromFuture(http
        .get(Uri.parse('$baseUrl/getOrders?userId=$userId'))
        .then((response) {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) =>
                serializers.deserializeWith(Order.serializer, item) as Order)
            .toList();
      }
      return [];
    }));
  }

  @override
  Future<String?> uploadProfilePhotoBytes(
      String userId, List<int> bytes, String fileName) async {
    return null;
  }
}
