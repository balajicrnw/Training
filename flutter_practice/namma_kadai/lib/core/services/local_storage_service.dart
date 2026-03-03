import '../../model/product.dart';
import '../../model/cart_item.dart';
import '../../model/order.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class LocalStorageService {
  Future<void> init();
  
  // Products
  Future<List<Product>> getProducts();
  Future<void> insertProduct(Product product);
  Future<void> deleteProduct(int id);
  
  // Cart
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> updateCartQuantity(int productId, int quantity);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
  
  // Orders
  Future<List<Order>> getOrders();
  Future<void> placeOrder(Order order);

  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<void> signOut();
  Stream<User?> authStateChanges();
}
