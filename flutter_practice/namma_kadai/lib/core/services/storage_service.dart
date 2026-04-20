import 'auth_service.dart';
import '../../model/user_model.dart';
import '../../model/product.dart';
import '../../model/cart_item.dart';
import '../../model/order.dart';

abstract class StorageService {
  Future<void> init();

  // User Data
  Future<void> saveUserData(AuthUser user, {String? name, String? gender});
  Stream<UserModel?> getUserData(String userId);

  // Products
  Future<List<Product>> getProducts();
  Future<void> saveProduct(Map<String, dynamic> data);
  Future<void> seedProducts();

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
