import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:namma_kadai/core/services/auth_service.dart';
import '../config/environment.dart';

class AppwriteAuthServiceImpl implements AuthService {
  final Account _account;
  final StreamController<AuthUser?> _authStateController =
      StreamController<AuthUser?>.broadcast();

  AppwriteAuthServiceImpl({Account? account})
    : _account =
          account ??
          Account(
            Client()
                .setEndpoint(Environment.appwritePublicEndpoint)
                .setProject(Environment.appwriteProjectId)
                .setSelfSigned(status: true),
          ) {
    _updateAuthState();
  }

  Future<void> _updateAuthState() async {
    try {
      final user = await _account.get();
      _authStateController.add(_mapUser(user));
    } catch (_) {
      _authStateController.add(null);
    }
  }

  AuthUser? _mapUser(models.User? user) {
    if (user == null) return null;
    return AuthUser(id: user.$id, email: user.email);
  }

  // 🔄 Auth state changes
  @override
  Stream<AuthUser?> authStateChanges() => _authStateController.stream;

  // 🔐 Sign In
  @override
  Future<AuthUser?> signIn(String email, String password) async {
    try {
      // Check if session exists and delete it if it does to avoid 401
      try {
        await _account.getSession(sessionId: 'current');
        await _account.deleteSession(sessionId: 'current');
      } catch (_) {
        // No active session, ignore
      }

      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final user = await _account.get();
      final authUser = _mapUser(user);
      _authStateController.add(authUser);
      return authUser;
    } on AppwriteException catch (e) {
      print("Appwrite Sign In Error: ${e.code} - ${e.message}");
      return null;
    }
  }

  // 🚪 Sign Out
  @override
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (_) {}
    _authStateController.add(null);
  }

  // 📝 Sign Up
  @override
  Future<AuthUser?> signUp(String email, String password) async {
    if (password.length < 8) {
      throw Exception('Password must be at least 8 characters long.');
    }

    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );

      // auto login after signup
      return await signIn(email, password);
    } on AppwriteException catch (e) {
      print("Appwrite Sign Up Error: ${e.code} - ${e.message}");
      rethrow;
    }
  }
}
