import 'package:flutter/material.dart';
import 'package:sourcegen_practice/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User(name: 'Balaji', age: 21);

    final json = user.toJson();

    final parsedUser = UserJson.fromJson(json);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text('SourceGen User Demo')),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Original User',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),

              Text('Age: ${user.age}', style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 30),

              const Text(
                'Generated JSON',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(json.toString(), style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 30),

              const Text(
                'Parsed User',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'Name: ${parsedUser.name}',
                style: const TextStyle(fontSize: 18),
              ),

              Text(
                'Age: ${parsedUser.age}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
