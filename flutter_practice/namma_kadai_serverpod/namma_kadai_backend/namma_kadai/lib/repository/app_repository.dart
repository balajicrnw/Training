import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namma_kadai_shared/namma_kadai_shared.dart';
import 'package:namma_kadai/services/serverpod_service.dart';
import 'package:namma_kadai/services/firebase_auth_service_impl.dart';
import '../config/environment.dart';

class AppRepository {
  // late final Client _client = Client()
  //   ..setEndpoint(Environment.appwritePublicEndpoint)
  //   ..setProject(Environment.appwriteProjectId)
  //   ..setSelfSigned(status: true);

  final StorageService storageService = ServerpodService();
  final AuthService authService = AuthServiceImpl(FirebaseAuth.instance);

  Future<void> init() => storageService.init();
}
