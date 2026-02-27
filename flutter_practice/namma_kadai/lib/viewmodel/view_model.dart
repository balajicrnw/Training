import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../core/providers.dart';


class ProductNotifier extends StateNotifier<List<Product>> {
  final Ref ref;
  bool isLoading = false;
  String? error;

  ProductNotifier(this.ref) : super([]) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    error = null;
    try {
      final products = await ref.read(productRepositoryProvider).getProducts();
      state = products;
      isLoading = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
  }
}

final productViewModelProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier(ref);
});


class CartNotifier extends StateNotifier<List<CartItem>> {
  final Ref ref;
  bool isLoading = false;
  String? error;

  CartNotifier(this.ref) : super([]) {
    loadCart();
  }

  Future<void> loadCart() async {
    isLoading = true;
    error = null;
    try {
      final items = await ref.read(cartRepositoryProvider).getCartItems();
      state = items;
      isLoading = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
  }

  Future<void> addToCart(Product product) async {
    final item = CartItem((b) => b
      ..productId = product.id!
      ..title = product.title
      ..price = product.price
      ..imageUrl = product.imageUrl
      ..quantity = 1);
    await ref.read(cartRepositoryProvider).addToCart(item);
    await loadCart();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    await ref.read(cartRepositoryProvider).updateQuantity(productId, quantity);
    await loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await ref.read(cartRepositoryProvider).removeFromCart(productId);
    await loadCart();
  }

  double get totalAmount {
    return state.fold<double>(0.0, (sum, item) => sum + item.total);
  }
}

final cartViewModelProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier(ref);
});


class OrderNotifier extends StateNotifier<List<Order>> {
  final Ref ref;
  bool isLoading = false;
  String? error;

  OrderNotifier(this.ref) : super([]) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading = true;
    error = null;
    try {
      final orders = await ref.read(orderRepositoryProvider).getOrders();
      state = orders;
      isLoading = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
  }

  Future<void> placeOrder() async {
    final items = ref.read(cartViewModelProvider);
    if (items.isEmpty) return;

    final order = Order((b) => b
      ..items = ListBuilder<CartItem>(items)
      ..totalAmount = items.fold<double>(0.0, (sum, item) => sum + item.total)
      ..dateTime = DateTime.now().toUtc());

    try {
      await ref.read(orderRepositoryProvider).placeOrder(order);
      await loadOrders();
      await ref.read(cartViewModelProvider.notifier).loadCart();
    } catch (e) {
      error = e.toString();
    }
  }
}

final orderViewModelProvider =
    StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier(ref);
});
