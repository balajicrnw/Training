import 'package:firebase_auth/firebase_auth.dart';
import '../../model/user_model.dart';
import '../../model/product.dart';
import '../../model/cart_item.dart';
import '../../model/order.dart';

abstract class StorageService {
  Future<void> init();

  // User Data
  Future<void> saveUserData(
    User user, {
    String? name,
    String? username,
    String? gender,
  });
  Stream<UserModel?> getUserData(String userId);

  // Products
  Future<List<Product>> getProducts();

  // Cart
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> updateCartQuantity(String productId, int quantity);
  Future<void> removeFromCart(String productId);
  Future<void> clearCart();

  // Orders
  Stream<List<Order>> getOrders(String userId);
  Future<void> saveOrder(Order order);
}
