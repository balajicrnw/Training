import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import 'package:namma_kadai/core/services/storage_service.dart';
import '../core/services/auth_service.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/app_repository.dart';
import '../core/mixins/exception_handler_mixin.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) => AppRepository());

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  final repository = ref.watch(appRepositoryProvider);
  return repository.appwriteAuthService.authStateChanges();
});

final currentUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authStateProvider).asData?.value;
});

class AppNotifier extends StateNotifier<AppState> with ExceptionHandlerMixin {
  final AppRepository repository;
  final Ref _ref;
  StreamSubscription? _userDataSubscription;
  StreamSubscription? _ordersSubscription;

  AuthUser? get _currentUser => _ref.read(currentUserProvider);

  StorageService get firestore => repository.firestoreService;
  StorageService get appwriteStore => repository.appwriteStorageService;

  AppNotifier({required this.repository, required Ref ref})
    : _ref = ref,
      super(AppState.initial()) {
    _ref.listen<AuthUser?>(currentUserProvider, (previous, next) async {
      if (next != null) {
        startUserSubscriptions();
        await loadCart();
      } else {
        cancelUserSubscriptions();
        state = state.rebuild(
          (b) => b
            ..orders = ListBuilder<Order>([])
            ..userData = null
            ..cartItems = ListBuilder<CartItem>([]),
        );
      }
    });
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

  @override
  void dispose() {
    cancelUserSubscriptions();
    super.dispose();
  }

  Future<void> init() async {
    await repository.storageService.init();
    await appwriteStore.init();
    await loadProducts();
    await loadCart();
    if (_currentUser != null) {
      startUserSubscriptions();
    }
  }

  Future<void> loadProducts() async {
    try {
      final products = await repository.appwriteStorageService.getProducts();

      if (products.isEmpty) {
        print('DEBUG: Product list empty. Attempting auto-seeding...');
        await seedDatabase();
      } else {
        state = state.rebuild(
          (b) => b..products = ListBuilder<Product>(products),
        );
      }
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'Error getting products: $e',
      );
    }
  }

  Future<void> loadCart() async {
    await handleAsync(() async {
      final uid = _currentUser?.id;
      if (uid == null) {
        state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>([]));
        return;
      }
      final items = await appwriteStore.getCartItems();
      state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>(items));
    }, errorMessage: 'loadCart error');
  }

  Future<bool> addToCart(Product product) async {
    final existingItems = state.cartItems
        .where((item) => item.productId == product.id)
        .toList();

    if (existingItems.isNotEmpty) {
      final existingItem = existingItems.first;
      await updateQuantity(product.id!, existingItem.quantity + 1);
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

    await appwriteStore.addToCart(item);
    await loadCart();
    return true;
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await appwriteStore.updateCartQuantity(productId, quantity);
      await loadCart();
    }
  }

  Future<void> removeFromCart(String productId) async {
    await appwriteStore.removeFromCart(productId);
    await loadCart();
  }

  double get totalAmount =>
      state.cartItems.fold(0.0, (acc, item) => acc + item.total);

  Future<void> loadOrders() async {
    final uid = _currentUser?.id;
    if (uid == null) return;

    _ordersSubscription?.cancel();
    _ordersSubscription = appwriteStore
        .getOrders(uid)
        .listen(
          (orders) {
            final sortedOrders = orders.toList()
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
            state = state.rebuild(
              (b) => b..orders = ListBuilder<Order>(sortedOrders),
            );
          },
          onError: (error) {
            state = state.rebuild(
              (b) => b..errorMessage = 'Failed to load orders: $error',
            );
          },
        );
  }

  Future<void> loadUserData() async {
    final uid = _currentUser?.id;
    if (uid == null) return;

    _userDataSubscription?.cancel();
    _userDataSubscription = appwriteStore
        .getUserData(uid)
        .listen(
          (userData) {
            if (userData != null) {
              state = state.rebuild((b) => b..userData = userData.toBuilder());
            }
          },
          onError: (error) {
            state = state.rebuild(
              (b) => b..errorMessage = 'Failed to load user data: $error',
            );
          },
        );
  }

  Future<void> placeOrder() async {
    final items = state.cartItems.toList();
    if (items.isEmpty) return;

    final order = Order(
      (b) => b
        ..uid = _currentUser?.id
        ..items = ListBuilder<CartItem>(items)
        ..totalAmount = totalAmount
        ..dateTime = DateTime.now().toUtc(),
    );

    await handleAsync(() async {
      if (_currentUser != null) {
        await appwriteStore.saveOrder(order);
        await appwriteStore.clearCart();
      } else {
        await repository.storageService.saveOrder(order);
      }
      await loadOrders();
      await loadCart();
    }, errorMessage: 'placeOrder error');
  }

  Future<AuthUser?> login(String email, String password) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );
    try {
      final registered = await repository.appwriteAuthService
          .isAccountRegistered(email);
      if (!registered) {
        state = state.rebuild(
          (b) => b
            ..errorMessage = 'No account found with this email.'
            ..isLoading = false,
        );
        return null;
      }

      final user = await repository.appwriteAuthService.signIn(email, password);
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
        (b) => b..errorMessage = 'Password must be at least 8 characters long.',
      );
      return null;
    }

    AuthUser? user;
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );
    await handleAsync(() async {
      user = await repository.appwriteAuthService.signUp(
        email,
        password,
        name: name,
      );
      if (user != null) {
        await appwriteStore.saveUserData(user!, name: name, gender: gender);
      }
    }, errorMessage: 'Registration error');
    state = state.rebuild((b) => b..isLoading = false);
    return user;
  }

  Future<void> logout() async => repository.appwriteAuthService.signOut();

  // 📧 OTP Flow
  Future<bool> sendOtp(String email) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );
    try {
      await repository.appwriteAuthService.sendOtp(email);
      state = state.rebuild((b) => b..isLoading = false);
      return true;
    } catch (e) {
      String message = e.toString();
      if (message.toLowerCase().contains('user_not_found') ||
          message.toLowerCase().contains('user not found')) {
        state = state.rebuild(
          (b) => b..errorMessage = 'Please register first.',
        );
      } else {
        state = state.rebuild(
          (b) => b..errorMessage = 'Failed to send OTP: $e',
        );
      }
      state = state.rebuild((b) => b..isLoading = false);
      return false;
    }
  }

  Future<AuthUser?> verifyOtp(String email, String otp) async {
    state = state.rebuild(
      (b) => b
        ..errorMessage = null
        ..isLoading = true,
    );
    AuthUser? user;
    try {
      user = await repository.appwriteAuthService.verifyOtp(email, otp);
      if (user == null) {
        state = state.rebuild((b) => b..errorMessage = 'Invalid OTP code');
      }
    } catch (e) {
      state = state.rebuild(
        (b) => b..errorMessage = 'OTP Verification failed: $e',
      );
    }
    state = state.rebuild((b) => b..isLoading = false);
    return user;
  }

  void updateCategory(String category) {
    state = state.rebuild((b) => b..selectedCategory = category);
  }

  void updateSearchQuery(String query) {
    state = state.rebuild((b) => b..searchQuery = query);
  }

  Future<void> seedDatabase() async {
    try {
      await repository.appwriteStorageService.seedProducts();
      await loadProducts();
      state = state.rebuild(
        (b) => b..errorMessage = 'Database seeded successfully!',
      );
    } catch (e) {
      state = state.rebuild((b) => b..errorMessage = 'Seeding failed: $e');
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.rebuild((b) => b..errorMessage = null);
    }
  }
}

final appViewModelProvider = StateNotifierProvider<AppNotifier, AppState>((
  ref,
) {
  final repository = ref.watch(appRepositoryProvider);
  return AppNotifier(repository: repository, ref: ref)..init();
});
