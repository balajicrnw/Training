import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/local_storage_service.dart';
import '../model/product.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return ProductRepository(storageService);
});

class ProductRepository {
  final LocalStorageService storageService;

  ProductRepository(this.storageService);
}
