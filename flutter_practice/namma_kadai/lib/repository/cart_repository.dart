import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/local_storage_service.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return CartRepository(storageService);
});

class CartRepository {
  final LocalStorageService storageService;

  CartRepository(this.storageService);
}
