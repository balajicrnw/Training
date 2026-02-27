import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service_impl.dart';
import 'services/local_storage_service.dart';
import '../repository/product_repository.dart';
import '../repository/cart_repository.dart';
import '../repository/order_repository.dart';

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
