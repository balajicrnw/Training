import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:built_collection/built_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/app_state.dart';
import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../repository/app_repository.dart';
import '../core/mixins/exception_handler_mixin.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) => AppRepository());

final authStateProvider = StreamProvider<User?>((ref) {
  final repository = ref.watch(appRepositoryProvider);
  return repository.authService.authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).asData?.value;
});



class AppNotifier extends StateNotifier<AppState> with ExceptionHandlerMixin {
  final AppRepository repository;
  final Ref _ref;
  StreamSubscription? _userDataSubscription;
  StreamSubscription? _ordersSubscription;

  User? get _currentUser => _ref.read(currentUserProvider);

  AppNotifier({
    required this.repository,
    required Ref ref,
  })  : _ref = ref,
        super(AppState.initial()) {
    _ref.listen<User?>(currentUserProvider, (previous, next) {
      if (next != null) {
        startUserSubscriptions();
      } else {
        cancelUserSubscriptions();
        state = state.rebuild((b) => b
          ..orders = ListBuilder<Order>([])
          ..userData = null);
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
    await repository.init();
    await loadProducts();
    await loadCart();
    if (_currentUser != null) {
      startUserSubscriptions();
    }
  }


  Future<void> loadProducts() async {
    await handleAsync(
      () async {
        final products = await repository.storageService.getProducts();
        state = state.rebuild((b) => b..products = ListBuilder<Product>(products));
      },
      errorMessage: 'loadProducts error',
    );
  }


  Future<void> loadCart() async {
    await handleAsync(
      () async {
        final items = await repository.storageService.getCartItems();
        state = state.rebuild((b) => b..cartItems = ListBuilder<CartItem>(items));
      },
      errorMessage: 'loadCart error',
    );
  }

  Future<bool> addToCart(Product product) async {
    final existingItems = state.cartItems.where((item) => item.productId == product.id).toList();
    
    if (existingItems.isNotEmpty) {
      final existingItem = existingItems.first;
      if (kDebugMode) print('addToCart: Incrementing quantity for ${product.title}');
      await updateQuantity(product.id!, existingItem.quantity + 1);
      return true;
    }

    if (kDebugMode) print('addToCart: Adding new product ${product.title}');
    final item = CartItem((b) => b
      ..productId = product.id!
      ..title = product.title
      ..price = product.price
      ..imageUrl = product.imageUrl
      ..quantity = 1);

    await repository.storageService.addToCart(item);
    await loadCart();
    return true;
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (kDebugMode) print('updateQuantity: ID $productId, New Qty $quantity');
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await repository.storageService.updateCartQuantity(productId, quantity);
      await loadCart();
    }
  }

  Future<void> removeFromCart(int productId) async {
    await repository.storageService.removeFromCart(productId);
    await loadCart();
  }

  double get totalAmount =>
      state.cartItems.fold(0.0, (acc, item) => acc + item.total);

  Future<void> loadOrders() async {
    final uid = _currentUser?.uid;
    if (uid == null) return;

    _ordersSubscription?.cancel();
    _ordersSubscription = repository.firestoreService.getOrderHistory(uid).listen(
      (orders) {
        final sortedOrders = orders.toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
        
        state = state.rebuild((b) => b..orders = ListBuilder<Order>(sortedOrders));
      },
      onError: (error) {
        if (kDebugMode) print('loadOrders: Error: $error');
        state = state.rebuild((b) => b..errorMessage = 'Failed to load orders: $error');
      },
    );
  }

  Future<void> loadUserData() async {
    final uid = _currentUser?.uid;
    if (uid == null) return;

    _userDataSubscription?.cancel();
    _userDataSubscription = repository.firestoreService.getUserData(uid).listen(
      (userData) {
        if (userData != null) {
          state = state.rebuild((b) => b..userData = userData.toBuilder());
        }
      },
      onError: (error) {
        if (kDebugMode) print('loadUserData: Error: $error');
        state = state.rebuild((b) => b..errorMessage = 'Failed to load user data: $error');
      },
    );
  }

  Future<void> placeOrder() async {
    final items = state.cartItems.toList();
    if (items.isEmpty) return;

    final order = Order((b) => b
      ..uid = _currentUser?.uid
      ..items = ListBuilder<CartItem>(items)
      ..totalAmount = totalAmount
      ..dateTime = DateTime.now().toUtc());

    await handleAsync(
      () async {
        if (_currentUser != null) {
          await repository.firestoreService.saveOrder(_currentUser!.uid, repository.storageService.serializeOrder(order));
          await repository.storageService.clearCart();
        } else {
          await repository.storageService.placeOrder(order);
        }
        loadOrders();
        await loadCart();
      },
      errorMessage: 'placeOrder error',
    );
  }

  Future<User?> login(String email, String password) async {
    final user = await repository.authService.signIn(email, password);
    if (user == null) {
      state = state.rebuild((b) => b..errorMessage = 'Invalid email or password');
    }
    return user;
  }

  Future<User?> register({
    required String email,
    required String password,
    required String username,
    required String gender,
  }) async {
    User? user;
    state = state.rebuild((b) => b..errorMessage = null);
    await handleAsync(
      () async {
        user = await repository.authService.signUp(email, password);
        if (user != null) {
          await repository.firestoreService.saveUserData(
            user!,
            name: username,
            username: username,
            gender: gender,
          );
        }
      },
      errorMessage: 'Registration error',
      onError: (error) {
        String message = 'An unexpected error occurred during registration.';
        if (error is FirebaseAuthException) {
          if (error.code == 'email-already-in-use') message = 'This email is already in use.';
          if (error.code == 'weak-password') message = 'The password is too weak.';
          if (error.code == 'invalid-email') message = 'The email address is not valid.';
        }
        state = state.rebuild((b) => b..errorMessage = message);
      },
    );
    return user;
  }

  Future<void> logout() async => repository.authService.signOut();

  void updateCategory(String category) {
    state = state.rebuild((b) => b..selectedCategory = category);
  }

  void updateSearchQuery(String query) {
    state = state.rebuild((b) => b..searchQuery = query);
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.rebuild((b) => b..errorMessage = null);
    }
  }
}

final appViewModelProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  final repository = ref.watch(appRepositoryProvider);
  return AppNotifier(repository: repository, ref: ref)..init();
});
