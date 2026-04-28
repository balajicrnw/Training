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

  @override
  Stream<AuthUser?> authStateChanges() => _authStateController.stream;

  @override
  Future<AuthUser?> signIn(String email, String password) async {
    try {
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

  @override
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (_) {}
    _authStateController.add(null);
  }

  @override
  Future<AuthUser?> signUp(String email, String password) async {
    if (password.length < 8) {
      throw Exception('Password must be at least 8 characters long.');
    }

    try {
      // Use sanitized email as userId for consistency
      final userId = email
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          .toLowerCase();

      await _account.create(
        userId: userId.substring(0, userId.length > 36 ? 36 : userId.length),
        email: email,
        password: password,
      );

      // auto login after signup
      return await signIn(email, password);
    } on AppwriteException catch (e) {
      print("Appwrite Sign Up Error: ${e.code} - ${e.message}");
      if (e.code == 409) {
        // If user exists, try to log in
        return await signIn(email, password);
      }
      rethrow;
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    try {
      // Standardize userId: sanitized, lowercase, max 36 chars
      final userId = email
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          .toLowerCase();
      final finalUserId = userId.substring(
        0,
        userId.length > 36 ? 36 : userId.length,
      );

      try {
        await _account.create(
          userId: finalUserId,
          email: email,
          password: ID.unique(), // Placeholder
        );
        print("DEBUG: Created new placeholder account for OTP: $finalUserId");
      } catch (e) {
        // User likely exists, ignore
        print("DEBUG: User exists or error during placeholder creation: $e");
      }

      await _account.createEmailToken(userId: finalUserId, email: email);
      print("Appwrite OTP Sent to: $email (ID: $finalUserId)");
    } on AppwriteException catch (e) {
      print("Appwrite Send OTP Error: ${e.code} - ${e.message}");
      rethrow;
    }
  }

  @override
  Future<AuthUser?> verifyOtp(String email, String otp) async {
    try {
      final userId = email
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
          .toLowerCase();
      final finalUserId = userId.substring(
        0,
        userId.length > 36 ? 36 : userId.length,
      );

      print("DEBUG: Verifying OTP for $email (ID: $finalUserId)");

      await _account.createSession(userId: finalUserId, secret: otp);

      final user = await _account.get();
      final authUser = _mapUser(user);
      _authStateController.add(authUser);
      return authUser;
    } on AppwriteException catch (e) {
      print("Appwrite Verify OTP Error: ${e.code} - ${e.message}");
      return null;
    }
  }
  
  @override
  Future<bool> isAccountRegistered(String email) {
    throw UnimplementedError();
  }
}
