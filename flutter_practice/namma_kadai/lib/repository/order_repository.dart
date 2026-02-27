import '../core/services/local_storage_service.dart';
import '../model/order.dart';

class OrderRepository {
  final LocalStorageService _storageService;

  OrderRepository(this._storageService);

  Future<List<Order>> getOrders() => _storageService.getOrders();
  Future<void> placeOrder(Order order) => _storageService.placeOrder(order);
}
