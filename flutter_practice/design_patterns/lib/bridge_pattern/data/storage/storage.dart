import '../../core/models/user.dart';

abstract class Storage {
  Future<void> saveUser(User user);
  Future<List<User>> getUsers();
}