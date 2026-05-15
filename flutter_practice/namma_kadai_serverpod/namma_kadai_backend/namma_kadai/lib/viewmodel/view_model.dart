import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:namma_kadai/core/mixins/exception_handler_mixin.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import 'package:namma_kadai/core/services/storage_service.dart';

import '../model/app_state.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../repository/app_repository.dart';

final appViewModelProvider =
    StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier(
    repository: AppRepository(),
  )..init();
});

class AppNotifier extends StateNotifier<AppState> with ExceptionHandlerMixin {
  final AppRepository repository;

  StreamSubscription? _authSubscription;
  StreamSubscription? _userDataSubscription;
  StreamSubscription? _ordersSubscription;

  StorageService get storageService => repository.storageService;

  AuthService get authService => repository.authService;


  AppNotifier({
    required this.repository,
  }) : super(AppState.initial());

  Future<void> init() async {
    try {
      state = state.rebuild((b) => b..isLoading = true);

      await storageService.init();

      _authSubscription = authService.authStateChanges().listen((user) async {
        debugPrint('DEBUG: AuthNotifier: User changed to ${user?.email}');
        state = state.rebuild((b) => b
          ..authUser = user?.toBuilder()
          ..isAuthInitialChecked = true);

        if (user != null) {
          await loadCart();
          startUserSubscriptions();
        } else {
          cancelUserSubscriptions();

          state = state.rebuild(
            (b) => b
              ..cartItems = ListBuilder<CartItem>([])
              ..orders = ListBuilder<Order>([])
              ..userData = null,
          );
        }
      });

      await loadProducts();

      state = state.rebuild((b) => b..isLoading = false);
    } catch (e) {
      state = state.rebuild(
        (b) => b
          ..errorMessage = e.toString()
          ..isLoading = false,
      );
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    cancelUserSubscriptions();
    super.dispose();
  }

  void startUserSubscriptions() {
    loadOrders();
    loadUserData();
  }

  void cancelUserSubscriptions() {
    _userDataSubscription?.cancel();
    _ordersSubscription?.cancel();

    _userDataSubscription = null;
    _ordersSubscription = null;
  }

  Future<void> loadProducts() async {
    try {
      final products = await storageService.getProducts();

      if (products.isEmpty) {
        debugPrint('DEBUG: Product list empty. Auto seeding...');
        await seedDatabase();
      } else {
        state = state.rebuild(
          (b) => b..products = ListBuilder<Product>(products),
        );
      }
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'Error loading products: $e',
      );
    }
  }

  Future<void> seedDatabase() async {
    try {
      await storageService.seedProducts();

      await loadProducts();

      state = state.rebuild(
        (b) => b..errorMessage = 'Database seeded successfully!',
      );
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'Seeding failed: $e',
      );
    }
  }

  Future<void> loadCart() async {
    await handleAsync(() async {
      final uid = state.authUser?.id;

      if (uid == null) {
        state = state.rebuild(
          (b) => b..cartItems = ListBuilder<CartItem>([]),
        );
        return;
      }

      final items = await storageService.getCartItems();

      state = state.rebuild(
        (b) => b..cartItems = ListBuilder<CartItem>(items),
      );
    }, errorMessage: 'Load cart error');
  }

  Future<bool> addToCart(Product product) async {
    final existingItems =
        state.cartItems.where((item) => item.productId == product.id).toList();

    if (existingItems.isNotEmpty) {
      final existingItem = existingItems.first;

      await updateQuantity(
        product.id!,
        existingItem.quantity + 1,
      );

      return true;
    }

    final item = CartItem(
      (b) => b
        ..productId = product.id!
        ..title = product.title
        ..price = product.price
        ..imageUrl = product.imageUrl
        ..quantity = 1,
    );

    await storageService.addToCart(item);

    await loadCart();

    return true;
  }

  Future<void> updateQuantity(
    String productId,
    int quantity,
  ) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await storageService.updateCartQuantity(
        productId,
        quantity,
      );

      await loadCart();
    }
  }

  Future<void> removeFromCart(String productId) async {
    await storageService.removeFromCart(productId);

    await loadCart();
  }

  double get totalAmount {
    return state.cartItems.fold(
      0.0,
      (acc, item) => acc + item.total,
    );
  }

  Future<void> loadOrders() async {
    final uid = state.authUser?.id;

    if (uid == null) return;

    _ordersSubscription?.cancel();

    _ordersSubscription = storageService.getOrders(uid).listen(
      (orders) {
        final sortedOrders = orders.toList()
          ..sort(
            (a, b) => b.dateTime.compareTo(a.dateTime),
          );

        state = state.rebuild(
          (b) => b..orders = ListBuilder<Order>(sortedOrders),
        );
      },
      onError: (error) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Failed loading orders: $error',
        );
      },
    );
  }

  Future<void> placeOrder() async {
    final items = state.cartItems.toList();

    if (items.isEmpty) return;

    final order = Order(
      (b) => b
        ..uid = state.authUser?.id
        ..items = ListBuilder<CartItem>(items)
        ..totalAmount = totalAmount
        ..dateTime = DateTime.now().toUtc(),
    );

    await handleAsync(() async {
      if (state.authUser != null) {
        await storageService.saveOrder(order);

        await storageService.clearCart();
      }

      await loadOrders();
      await loadCart();
    }, errorMessage: 'Place order error');
  }

  // ========================= USER DATA =========================

  Future<void> loadUserData() async {
    final uid = state.authUser?.id;

    if (uid == null) return;

    _userDataSubscription?.cancel();

    _userDataSubscription = storageService.getUserData(uid).listen(
      (userData) {
        if (userData != null) {
          state = state.rebuild(
            (b) => b..userData = userData.toBuilder(),
          );
        }
      },
      onError: (error) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Failed loading user data: $error',
        );
      },
    );
  }

  Future<void> updateProfilePhoto(
    List<int> bytes,
    String fileName,
  ) async {
    final uid = state.authUser?.id;

    if (uid == null) return;

    state = state.rebuild((b) => b..isLoading = true);

    try {
      await storageService.uploadProfilePhotoBytes(
        uid,
        bytes,
        fileName,
      );
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'Photo upload failed: $e',
      );
    } finally {
      state = state.rebuild((b) => b..isLoading = false);
    }
  }

  Future<AuthUser?> login(
    String email,
    String password,
  ) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );

    try {
      final user = await authService.signIn(
        email,
        password,
      );

      if (user == null) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Invalid email or password',
        );
      }

      state = state.rebuild((b) => b..isLoading = false);

      return user;
    } catch (e) {
      state = state.rebuild(
        (b) => b
          ..errorMessage = e.toString()
          ..isLoading = false,
      );

      return null;
    }
  }

  Future<AuthUser?> register({
    required String email,
    required String password,
    required String name,
    required String gender,
  }) async {
    if (password.length < 8) {
      state = state.rebuild(
        (b) => b..errorMessage = 'Password must be at least 8 characters.',
      );

      return null;
    }

    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );

    AuthUser? user;

    await handleAsync(() async {
      user = await authService.signUp(
        email,
        password,
        name: name,
      );

      if (user != null) {
        await storageService.saveUserData(
          user!,
          name: name,
          gender: gender,
        );
      }
    }, errorMessage: 'Registration failed');

    state = state.rebuild((b) => b..isLoading = false);

    return user;
  }

  Future<void> logout() async {
    await authService.signOut();
  }

  Future<bool> sendOtp(String email) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );

    try {
      await authService.sendOtp(email);

      state = state.rebuild((b) => b..isLoading = false);

      return true;
    } catch (e) {
      final message = e.toString().toLowerCase();

      if (message.contains('user_not_found') ||
          message.contains('user not found')) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Please register first.',
        );
      } else {
        state = state.rebuild(
          (b) => b..errorMessage = 'Failed sending OTP: $e',
        );
      }

      state = state.rebuild((b) => b..isLoading = false);

      return false;
    }
  }

  Future<AuthUser?> verifyOtp(
    String email,
    String otp,
  ) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );

    AuthUser? user;

    try {
      user = await authService.verifyOtp(
        email,
        otp,
      );

      if (user == null) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Invalid OTP code',
        );
      }
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'OTP verification failed: $e',
      );
    }

    state = state.rebuild((b) => b..isLoading = false);

    return user;
  }

  void updateCategory(String category) {
    state = state.rebuild(
      (b) => b..selectedCategory = category,
    );
  }

  void updateSearchQuery(String query) {
    state = state.rebuild(
      (b) => b..searchQuery = query,
    );
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.rebuild(
        (b) => b..errorMessage = null,
      );
    }
  }
}
