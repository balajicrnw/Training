import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import 'package:namma_kadai/services/auth_service_impl.dart';
import '../core/services/local_storage_service.dart';
import '../core/services/firebase_firestore_service.dart';
import '../services/local_storage_service_impl.dart';
import '../services/firebase_firestore_service_impl.dart';

class AppRepository {
 
  final LocalStorageService storageService = LocalStorageServiceImpl();
  final AuthService authService = AuthServiceImpl(FirebaseAuth.instance);
  final FirebaseFirestoreService firestoreService =
      FirebaseFirestoreServiceImpl();

  
  Future<void> init() => storageService.init();
}