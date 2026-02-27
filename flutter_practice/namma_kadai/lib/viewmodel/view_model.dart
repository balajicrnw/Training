import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/product_repository.dart';
import '../repository/cart_repository.dart';
import '../repository/order_repository.dart';

class AppNotifier extends StateNotifier<AppState> {
  final Ref ref;

  AppNotifier(this.ref) : super(AppState.initial());

  Future<void> init() async {
    await loadProducts();
    await loadCart();
    await loadOrders();
  }

  Future<void> loadProducts() async {
    try {
      final products =
          await ref.read(productRepositoryProvider).storageService.getProducts();
      state = state.rebuild((b) => b..products = ListBuilder<Product>(products));
    } catch (e) {
      print('loadProducts error: $e');
    }
  }

  Future<void> loadCart() async {
    try {
      final items =
          await ref.read(cartRepositoryProvider).storageService.getCartItems();
      state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>(items));
    } catch (e) {
      print('loadCart error: $e');
    }
  }

  Future<void> loadOrders() async {
    try {
      final orders =
          await ref.read(orderRepositoryProvider).storageService.getOrders();
      state = state.rebuild((b) => b..orders = ListBuilder<Order>(orders));
    } catch (e) {
      print('loadOrders error: $e');
    }
  }

  Future<void> addToCart(Product product) async {
    final item = CartItem((b) => b
      ..productId = product.id!
      ..title = product.title
      ..price = product.price
      ..imageUrl = product.imageUrl
      ..quantity = 1);
    await ref.read(cartRepositoryProvider).storageService.addToCart(item);
    await loadCart();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    await ref
        .read(cartRepositoryProvider)
        .storageService
        .updateCartQuantity(productId, quantity);
    await loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await ref.read(cartRepositoryProvider).storageService.removeFromCart(productId);
    await loadCart();
  }

  double get totalAmount {
    return state.cartItems.fold<double>(0.0, (sum, item) => sum + item.total);
  }

  Future<void> placeOrder() async {
    final items = state.cartItems.toList();
    if (items.isEmpty) return;

    final order = Order((b) => b
      ..items = ListBuilder<CartItem>(items)
      ..totalAmount = items.fold<double>(0.0, (sum, item) => sum + item.total)
      ..dateTime = DateTime.now().toUtc());

    try {
      await ref.read(orderRepositoryProvider).storageService.placeOrder(order);
      await loadOrders();
      await loadCart();
    } catch (e) {
      print('placeOrder error: $e');
    }
  }
}

final appViewModelProvider =
    StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier(ref)..init();
});
