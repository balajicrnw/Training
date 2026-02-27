import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/local_storage_service.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return OrderRepository(storageService);
});

class OrderRepository {
  final LocalStorageService storageService;

  OrderRepository(this.storageService);
}
