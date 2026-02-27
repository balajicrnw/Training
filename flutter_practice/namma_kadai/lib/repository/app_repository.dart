import '../model/product.dart';
import '../model/cart_item.dart';
import '../model/order.dart';
import '../core/services/local_storage_service.dart';

class AppRepository {
  final LocalStorageService storageService;

  AppRepository(this.storageService);

}
