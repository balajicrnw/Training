import '../creator/api_service.dart';

/// Concrete Creator / Product for the DEV environment.
class DevApiService implements ApiService {
  @override
  String getBaseUrl() => 'https://dev.api.example.com/v1';

  @override
  Future<String> fetchData() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));
    return 'Dev Environment Data:\n[ { "id": 1, "name": "Dev User (John)" } ]';
  }
}
