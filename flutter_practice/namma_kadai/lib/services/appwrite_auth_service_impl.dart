import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:namma_kadai/core/services/auth_service.dart';
import '../config/environment.dart';

class AppwriteAuthServiceImpl implements AuthService {
  final Account _account;
  final Databases _db;
  final _ctrl = StreamController<AuthUser?>.broadcast();

  static const _dbId = Environment.appwriteDatabaseId;
  static const _users = Environment.appwriteUsersCollectionId;

  AppwriteAuthServiceImpl({Account? account, Databases? databases})
      : _account = account ??
            Account(
              Client()
                  .setEndpoint(Environment.appwritePublicEndpoint)
                  .setProject(Environment.appwriteProjectId)
                  .setSelfSigned(status: true),
            ),
        _db = databases ??
            Databases(
              Client()
                  .setEndpoint(Environment.appwritePublicEndpoint)
                  .setProject(Environment.appwriteProjectId)
                  .setSelfSigned(status: true),
            ) {
    _update();
  }

  String _getId(String email) {
    final id = email.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
    return id.substring(0, id.length > 36 ? 36 : id.length);
  }

  Future<void> _update() async {
    try {
      final user = await _account.get();
      _ctrl.add(AuthUser(id: user.$id, email: user.email));
    } catch (e) {
      print("CRITICAL: Error updating auth state: $e");
      _ctrl.add(null);
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() => _ctrl.stream;

  @override
  Future<AuthUser?> signIn(String email, String password) async {
    try {
      try {
        await _account.deleteSession(sessionId: 'current');
      } catch (e) {
        print("CRITICAL: Error deleting session: $e");
      }
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      final user = await _account.get();
      final authUser = AuthUser(id: user.$id, email: user.email);
      _ctrl.add(authUser);
      return authUser;
    } catch (e) {
      print("CRITICAL: Error signing in: $e");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      print("CRITICAL: Error signing out: $e");
    }
    _ctrl.add(null);
  }

  @override
  Future<AuthUser?> signUp(
    String email,
    String password, {
    String? name,
  }) async {
    if (password.length < 8)
      throw Exception('Password must be at least 8 chars.');
    try {
      final id = _getId(email);
      await _account.create(
        userId: id,
        email: email,
        password: password,
        name: name,
      );
      return await signIn(email, password);
    } on AppwriteException catch (e) {
      if (e.code == 409) return await signIn(email, password);
      rethrow;
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    final id = _getId(email);

    final exists = await isAccountRegistered(email);

    if (!exists) {
      throw Exception("USER_NOT_FOUND");
    }

    await _account.createEmailToken(userId: id, email: email);
  }

  @override
  Future<AuthUser?> verifyOtp(String email, String otp) async {
    try {
      final id = _getId(email);
      await _account.createSession(userId: id, secret: otp);
      final user = await _account.get();
      final authUser = AuthUser(id: user.$id, email: user.email);
      _ctrl.add(authUser);
      return authUser;
    } catch (e) {
      print("CRITICAL: Error verifying OTP: $e");
      return null;
    }
  }

  @override
  Future<bool> isAccountRegistered(String email) async {
    try {
      await _db.getDocument(
        databaseId: _dbId,
        collectionId: _users,
        documentId: _getId(email),
      );
      return true;
    } catch (e) {
      print("CRITICAL: Error checking if account is registered: $e");
      return false;
    }
  }
}
