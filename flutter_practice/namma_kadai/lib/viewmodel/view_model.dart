import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/app_repository.dart';
import '../core/services/local_storage_service.dart';
import '../services/local_storage_service_impl.dart';

final localStorageServiceProvider = LocalStorageServiceImpl();

final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepository(localStorageServiceProvider);
});

class AppNotifier extends StateNotifier<AppState> {
  final AppRepository repository;

  AppNotifier({
    required this.repository,
  }) : super(AppState.initial());

  Future<void> init() async {
    await loadProducts();
    await loadCart();
    await loadOrders();
  }

  Future<void> loadProducts() async {
    try {
      final products = await repository.storageService.getProducts();
      state = state.rebuild((b) => b..products = ListBuilder<Product>(products));
    } catch (e) {
      print('loadProducts error: $e');
    }
  }

  Future<void> loadCart() async {
    try {
      final items = await repository.storageService.getCartItems();
      state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>(items));
    } catch (e) {
      print('loadCart error: $e');
    }
  }

  Future<void> loadOrders() async {
    try {
      final orders = await repository.storageService.getOrders();
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
    await repository.storageService.addToCart(item);
    await loadCart();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    await repository.storageService.updateCartQuantity(productId, quantity);
    await loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await repository.storageService.removeFromCart(productId);
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
      await repository.storageService.placeOrder(order);
      await loadOrders();
      await loadCart();
    } catch (e) {
      print('placeOrder error: $e');
    }
  }
}

final appViewModelProvider =
    StateNotifierProvider<AppNotifier, AppState>((ref) {
  final repository = ref.watch(appRepositoryProvider);

  return AppNotifier(
    repository: repository,
  )..init();
});
