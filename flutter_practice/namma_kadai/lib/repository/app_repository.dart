import 'package:firebase_auth/firebase_auth.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import 'package:namma_kadai/services/auth_service_impl.dart';
import '../core/services/storage_service.dart';
import '../services/local_storage_service_impl.dart';
import '../services/firebase_firestore_service_impl.dart';

class AppRepository {
 
  final StorageService storageService = LocalStorageServiceImpl();
  final AuthService authService = AuthServiceImpl(FirebaseAuth.instance);
  final StorageService firestoreService = FirebaseFirestoreServiceImpl();

  
  Future<void> init() => storageService.init();
}