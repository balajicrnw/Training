import '../core/services/local_storage_service.dart';
import '../services/local_storage_service_impl.dart';

class AppRepository {
  final LocalStorageService storageService = LocalStorageServiceImpl();

  Future<void> init() => storageService.init();
}