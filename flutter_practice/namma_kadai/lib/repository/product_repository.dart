import '../core/services/local_storage_service.dart';
import '../model/product.dart';

class ProductRepository {
  final LocalStorageService _storageService;

  ProductRepository(this._storageService);

  Future<List<Product>> getProducts() => _storageService.getProducts();
}
