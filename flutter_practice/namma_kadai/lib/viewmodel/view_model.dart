import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/app_repository.dart';
import '../core/mixins/exception_handler_mixin.dart';

class AppNotifier extends StateNotifier<AppState>
    with ExceptionHandlerMixin {
  final AppRepository repository;

  AppNotifier({
    required this.repository,
  }) : super(AppState.initial());

  Future<void> init() async {
    await repository.init();
    await loadProducts();
    await loadCart();
    await loadOrders();
  }



  Future<void> loadProducts() async {
    await handleAsync(
      () async {
        final products =
            await repository.storageService.getProducts();

        state = state.rebuild(
          (b) => b..products = ListBuilder<Product>(products),
        );
      },
      errorMessage: 'loadProducts error',
    );
  }

 

  Future<void> loadCart() async {
    await handleAsync(
      () async {
        final items =
            await repository.storageService.getCartItems();

        state = state.rebuild(
          (b) => b..cartItems = ListBuilder<CartItem>(items),
        );
      },
      errorMessage: 'loadCart error',
    );
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
    await repository.storageService
        .updateCartQuantity(productId, quantity);

    await loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await repository.storageService.removeFromCart(productId);
    await loadCart();
  }

  double get totalAmount {
    return state.cartItems
        .fold<double>(0.0, (sum, item) => sum + item.total);
  }

 

  Future<void> loadOrders() async {
    await handleAsync(
      () async {
        final orders =
            await repository.storageService.getOrders();

        state = state.rebuild(
          (b) => b..orders = ListBuilder<Order>(orders),
        );
      },
      errorMessage: 'loadOrders error',
    );
  }

  Future<void> placeOrder() async {
    final items = state.cartItems.toList();
    if (items.isEmpty) return;

    final order = Order((b) => b
      ..items = ListBuilder<CartItem>(items)
      ..totalAmount =
          items.fold<double>(0.0, (sum, item) => sum + item.total)
      ..dateTime = DateTime.now().toUtc());

    await handleAsync(
      () async {
        await repository.storageService.placeOrder(order);
        await loadOrders();
        await loadCart();
      },
      errorMessage: 'placeOrder error',
    );
  }
}


final appViewModelProvider =
    StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier(
    repository: AppRepository(),
  )..init();
});