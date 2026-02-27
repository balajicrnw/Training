import '../core/services/local_storage_service.dart';
import '../model/product.dart';

class ProductRepository {
  final LocalStorageService storageService;

  ProductRepository(this.storageService);
}
