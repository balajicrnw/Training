import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:namma_kadai/core/services/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthServiceImpl(this._firebaseAuth);

  AuthUser? _mapUser(User? user) {
    if (user == null) return null;
    return AuthUser(id: user.uid, email: user.email ?? '');
  }

  @override
  Stream<AuthUser?> authStateChanges() =>
      _firebaseAuth.authStateChanges().map(_mapUser);

  @override
  Future<AuthUser?> signIn(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("Firebase Sign In Error: ${e.code} - ${e.message}");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser?> signUp(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception(
          'The email address is already in use by another account.',
        );
      }
      print("Firebase Sign Up Error: ${e.code} - ${e.message}");
      rethrow;
    }
  }
}
