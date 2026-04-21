import 'package:appwrite/appwrite.dart';

void main() {
  final client = Client();
  final storage = Storage(client);
  final db = Databases(client);

  // Checking for existence of management methods
  print('Storage.createBucket: ${storage.runtimeType.toString()}');
}
