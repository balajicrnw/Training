import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/app_state.dart';
import '../../model/order.dart';
import '../../model/product.dart';
import '../../model/cart_item.dart';
import '../../viewmodel/view_model.dart';

extension AppProviderShortcuts on WidgetRef {

  // 🔹 Full state
  AppState get state => watch(appViewModelProvider);

  // 🔹 Notifier
  AppNotifier get notifier => read(appViewModelProvider.notifier);

  // 🔹 Direct shortcuts (WATCH)
  List<Order> get orders => watch(appViewModelProvider).orders.toList();

  List<Product> get products =>
      watch(appViewModelProvider).products.toList();

  List<CartItem> get cartItems =>
      watch(appViewModelProvider).cartItems.toList();

  double get totalAmount =>
      watch(appViewModelProvider.notifier).totalAmount;
}