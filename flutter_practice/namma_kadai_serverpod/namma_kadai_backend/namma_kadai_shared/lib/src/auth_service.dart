import 'models/auth_user.dart';
export 'models/auth_user.dart';

abstract class AuthService {
  Future<AuthUser?> signIn(String email, String password);
  Future<AuthUser?> signUp(String email, String password, {String? name});
  Future<void> signOut();
  Stream<AuthUser?> authStateChanges();
  Future<void> sendOtp(String email);
  Future<AuthUser?> verifyOtp(String email, String otp);
}
