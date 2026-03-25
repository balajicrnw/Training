import '../creator/api_service.dart';

/// Concrete Creator / Product for the PROD environment.
class ProdApiService implements ApiService {
  @override
  String getBaseUrl() => 'https://api.example.com/v1';

  @override
  Future<String> fetchData() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));
    return 'Prod Environment Data:\n[ { "id": 99, "name": "Prod User (Alice)" } ]';
  }
}
