import '../core/services/local_storage_service.dart';
import '../model/cart_item.dart';

class CartRepository {
  final LocalStorageService _storageService;

  CartRepository(this._storageService);

  Future<List<CartItem>> getCartItems() => _storageService.getCartItems();

  Future<void> addToCart(CartItem item) => _storageService.addToCart(item);

  Future<void> updateQuantity(int productId, int quantity) => _storageService.updateCartQuantity(productId, quantity);
  Future<void> removeFromCart(int productId) => _storageService.removeFromCart(productId);
  Future<void> clearCart() => _storageService.clearCart();
}
