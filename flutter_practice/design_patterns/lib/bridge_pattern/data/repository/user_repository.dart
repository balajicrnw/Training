import '../../core/models/user.dart';
import '../storage/storage.dart';

class UserRepository {
  final Storage storage; // <-- Bridge connection

  UserRepository(this.storage);

  Future<void> addUser(User user) {
    return storage.saveUser(user);
  }

  Future<List<User>> fetchUsers() {
    return storage.getUsers();
  }  
}