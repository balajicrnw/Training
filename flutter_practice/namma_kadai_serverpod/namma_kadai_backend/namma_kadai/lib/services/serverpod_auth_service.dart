import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:namma_kadai_shared/namma_kadai_shared.dart';

class ServerpodAuthService implements AuthService {
  final String baseUrl = 'http://localhost:8082';

  // Holds the current user and broadcasts changes to listeners
  final StreamController<AuthUser?> _authController =
      StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;

  @override
  Stream<AuthUser?> authStateChanges() async* {
    yield _currentUser;
    yield* _authController.stream;
  }

  @override
  Future<AuthUser?> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signIn'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && data['id'] != null) {
        final user = AuthUser((b) => b
          ..id = data['id'] as String
          ..email = data['email'] as String);
        _currentUser = user;
        _authController.add(user);
        return user;
      } else {
        final errorCode = data['error'] ?? 'unknown-error';
        print('ServerpodAuth signIn error: $errorCode');
        return null;
      }
    } catch (e) {
      print('ServerpodAuth signIn exception: $e');
      return null;
    }
  }

  @override
  Future<AuthUser?> signUp(
    String email,
    String password, {
    String? name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signUp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && data['id'] != null) {
        final user = AuthUser((b) => b
          ..id = data['id'] as String
          ..email = data['email'] as String);
        _currentUser = user;
        _authController.add(user);
        return user;
      } else {
        final errorCode = data['error'] ?? 'unknown-error';
        if (errorCode == 'email-already-in-use') {
          throw Exception('The email address is already in use by another account.');
        }
        throw Exception(errorCode);
      }
    } catch (e) {
      print('ServerpodAuth signUp exception: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await http.post(
        Uri.parse('$baseUrl/auth/signOut'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (_) {}
    _currentUser = null;
    _authController.add(null);
  }

  @override
  Future<void> sendOtp(String email) async {
    throw UnimplementedError('OTP not supported in Serverpod auth');
  }

  @override
  Future<AuthUser?> verifyOtp(String email, String otp) async {
    throw UnimplementedError('OTP not supported in Serverpod auth');
  }
}
