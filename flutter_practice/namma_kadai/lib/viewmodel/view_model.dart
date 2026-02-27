import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/product_repository.dart';
import '../repository/cart_repository.dart';
import '../repository/order_repository.dart';
import '../core/services/local_storage_service.dart';
import '../services/local_storage_service_impl.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageServiceImpl();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return ProductRepository(storageService);
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return CartRepository(storageService);
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return OrderRepository(storageService);
});

class AppNotifier extends StateNotifier<AppState> {
  final ProductRepository productRepository;
  final CartRepository cartRepository;
  final OrderRepository orderRepository;

  AppNotifier({
    required this.productRepository,
    required this.cartRepository,
    required this.orderRepository,
  }) : super(AppState.initial());

  Future<void> init() async {
    await loadProducts();
    await loadCart();
    await loadOrders();
  }

  Future<void> loadProducts() async {
    try {
      final products = await productRepository.storageService.getProducts();
      state = state.rebuild((b) => b..products = ListBuilder<Product>(products));
    } catch (e) {
      print('loadProducts error: $e');
    }
  }

  Future<void> loadCart() async {
    try {
      final items = await cartRepository.storageService.getCartItems();
      state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>(items));
    } catch (e) {
      print('loadCart error: $e');
    }
  }

  Future<void> loadOrders() async {
    try {
      final orders = await orderRepository.storageService.getOrders();
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
    await cartRepository.storageService.addToCart(item);
    await loadCart();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    await cartRepository.storageService.updateCartQuantity(productId, quantity);
    await loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await cartRepository.storageService.removeFromCart(productId);
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
      await orderRepository.storageService.placeOrder(order);
      await loadOrders();
      await loadCart();
    } catch (e) {
      print('placeOrder error: $e');
    }
  }
}

final appViewModelProvider =
    StateNotifierProvider<AppNotifier, AppState>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  final cartRepository = ref.watch(cartRepositoryProvider);
  final orderRepository = ref.watch(orderRepositoryProvider);

  return AppNotifier(
    productRepository: productRepository,
    cartRepository: cartRepository,
    orderRepository: orderRepository,
  )..init();
});
