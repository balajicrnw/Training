import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart';
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

  UserModel? get userData =>
      watch(appViewModelProvider).userData;

  AuthUser? get authUser => watch(appViewModelProvider).authUser;

  bool get isAuthInitialChecked => watch(appViewModelProvider).isAuthInitialChecked;

  String get selectedCategory => watch(appViewModelProvider).selectedCategory;
  String get searchQuery => watch(appViewModelProvider).searchQuery;

  List<Product> get filteredProducts {
    final allProducts = products;
    final category = selectedCategory;
    final query = searchQuery.toLowerCase();

    return allProducts.where((p) {
      final matchesCategory = category == 'All' || p.category == category;
      final matchesSearch = query.isEmpty || 
                            p.title.toLowerCase().contains(query) ||
                            p.description.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}