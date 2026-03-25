import '../core/environment.dart';
import '../concrete_creators/dev_api_service.dart';
import '../concrete_creators/prod_api_service.dart';

/// Product (Abstract Service) and Creator combined in this variation.
abstract class ApiService {
  String getBaseUrl();
  Future<String> fetchData();

  /// Factory Method to instantiate the appropriate concrete service.
  /// Adding a new environment just requires a new case here, keeping UI isolated.
  static ApiService createService(Environment env) {
    switch (env) {
      case Environment.dev:
        return DevApiService();
      case Environment.prod:
        return ProdApiService();
    }
  }
}
