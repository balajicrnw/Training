import 'package:firebase_auth/firebase_auth.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import 'package:namma_kadai/services/auth_service_impl.dart';
import '../core/services/local_storage_service.dart';
import '../services/local_storage_service_impl.dart';

class AppRepository {
  final LocalStorageService storageService = LocalStorageServiceImpl();
  final AuthService authService = AuthServiceImpl(FirebaseAuth.instance);

  Future<void> init() => storageService.init();
}