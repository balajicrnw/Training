import 'storage.dart';
import '../../core/models/user.dart';

class LocalStorage implements Storage {
  final List<User> _cache = [
    User(id: "1", name: "Balaji"),
    User(id: "2", name: "Chukka"),
    User(id: "3", name: "Ganesh"),
    User(id: "4", name: "Ashwin"),
    User(id: "5", name: "Abinesh"),
  ];

  @override
  Future<void> saveUser(User user) async {
    _cache.add(user);
    print("💾 Saved locally: ${user.name}");
  }

  @override
  Future<List<User>> getUsers() async {
    print("📂 Fetching from LOCAL storage...");
    return _cache;
  }
}