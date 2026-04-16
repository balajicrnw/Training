class AuthUser {
  final String id;
  final String email;

  AuthUser({required this.id, required this.email});
}

abstract class AuthService {
  Future<AuthUser?> signIn(String email, String password);
  Future<AuthUser?> signUp(String email, String password);
  Future<void> signOut();
  Stream<AuthUser?> authStateChanges();
}
