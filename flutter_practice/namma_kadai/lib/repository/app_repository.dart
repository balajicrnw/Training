import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import 'package:namma_kadai/services/appwrite_auth_service_impl.dart';
import 'package:namma_kadai/services/appwrite_storage_service_impl.dart';
import 'package:namma_kadai/services/firebase_auth_service_impl.dart';
import '../core/services/storage_service.dart';
import '../services/local_storage_service_impl.dart';
import '../services/firebase_firestore_service_impl.dart';
import '../config/environment.dart';

class AppRepository {
  late final Client _client = Client()
    ..setEndpoint(Environment.appwritePublicEndpoint)
    ..setProject(Environment.appwriteProjectId)
    ..setSelfSigned(status: true);

  final StorageService storageService = LocalStorageServiceImpl();
  // final AuthService firebaseAuthService = AuthServiceImpl(FirebaseAuth.instance);

  late final AuthService appwriteAuthService =
      AppwriteAuthServiceImpl(client: _client);

  // final StorageService firestoreService = FirebaseFirestoreServiceImpl();
  late final StorageService appwriteStorageService =
      AppwriteStorageServiceImpl(client: _client);

  Future<void> init() => storageService.init();
}
