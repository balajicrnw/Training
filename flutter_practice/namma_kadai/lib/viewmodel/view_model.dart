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
import '../core/services/local_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

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

  User? get _currentUser => _ref.read(currentUserProvider);

  AppNotifier({
    required this.repository,
    required Ref ref,
  })  : _ref = ref,
        super(AppState.initial()) {
    _ref.listen<User?>(currentUserProvider, (previous, next) {
      if (next != null) {
        loadOrders();
        loadUserData();
      } else {
        state = state.rebuild((b) => b
          ..orders = ListBuilder<Order>([])
          ..userData = null);
      }
    });
  }

  Future<void> init() async {
    await repository.init();
    await loadProducts();
    await loadCart();
    if (_currentUser != null) {
      await loadOrders();
      await loadUserData();
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
    final exists = state.cartItems.any((item) => item.productId == product.id);
    if (exists) {
      return false;
    }

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
      state.cartItems.fold(0.0, (sum, item) => sum + item.total);

  Future<void> loadOrders() async {
    final uid = _currentUser?.uid;
    if (uid == null) {
      if (kDebugMode) print('loadOrders: No user logged in');
      return;
    }

    if (kDebugMode) print('loadOrders: Fetching for UID $uid');

    await handleAsync(
      () async {
        final orderMaps = await repository.firestoreService.getOrderHistory(uid);
        if (kDebugMode) print('loadOrders: Fetched ${orderMaps.length} orders');

        final orders = orderMaps.map((map) {
          final mutableMap = Map<String, dynamic>.from(map);
          mutableMap['uid'] = uid; 
          
          if (mutableMap['orderDate'] is Timestamp) {
            mutableMap['dateTime'] = (mutableMap['orderDate'] as Timestamp).microsecondsSinceEpoch;
          } else if (mutableMap['dateTime'] == null) {
            mutableMap['dateTime'] = DateTime.now().microsecondsSinceEpoch;
          }

          mutableMap.remove('orderDate');
          
          try {
            return repository.storageService.deserializeOrder(mutableMap);
          } catch (e) {
            if (kDebugMode) print('loadOrders: Deserialization error for order ${mutableMap['id']}: $e');
            rethrow;
          }
        }).toList();

      
        orders.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        
        state = state.rebuild((b) => b..orders = ListBuilder<Order>(orders));
      },
      errorMessage: 'loadOrders error',
      onError: (error) {
        if (kDebugMode) print('loadOrders: Error fetching or processing: $error');
        state = state.rebuild((b) => b..errorMessage = 'Failed to load orders: $error');
      },
    );
  }

  Future<void> loadUserData() async {
    final uid = _currentUser?.uid;
    if (uid == null) return;

    if (kDebugMode) print('loadUserData: Fetching for UID $uid');

    await handleAsync(
      () async {
        final data = await repository.firestoreService.getUserData(uid);
        if (data != null) {
          if (kDebugMode) print('loadUserData: Success');
          state = state.rebuild((b) => b..userData = BuiltMap<String, dynamic>(data).toBuilder());
        } else {
          if (kDebugMode) print('loadUserData: No data found');
        }
      },
      errorMessage: 'loadUserData error',
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
        await loadOrders();
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
