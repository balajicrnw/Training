import 'package:appwrite/appwrite.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart';
import 'package:namma_kadai/services/serverpod_service.dart';
import 'package:namma_kadai/services/serverpod_auth_service.dart';
import '../config/environment.dart';

class AppRepository {
  // late final Client _client = Client()
  //   ..setEndpoint(Environment.appwritePublicEndpoint)
  //   ..setProject(Environment.appwriteProjectId)
  //   ..setSelfSigned(status: true);

  final _serverpodService = ServerpodService();
  StorageService get storageService => _serverpodService;
  final AuthService authService = ServerpodAuthService();

  void setCurrentUser(String? userId) {
    _serverpodService.currentUserId = userId;
  }

  Future<void> init() => storageService.init();
}
