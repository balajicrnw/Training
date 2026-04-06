import 'storage.dart';
import '../../core/models/user.dart';

class CloudStorage implements Storage {
  final List<User> _server = [
    User(id: "1", name: "Balaji"),
    User(id: "2", name: "Chukka"),
    User(id: "3", name: "Ganesh"),
    User(id: "4", name: "Ashwin"),
    User(id: "5", name: "Abinesh"),
  ];

  @override
  Future<void> saveUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _server.add(user);
    print("☁️ Uploaded to CLOUD: ${user.name}");
  }

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("☁️ Fetching from CLOUD...");
    return _server;
  }
}