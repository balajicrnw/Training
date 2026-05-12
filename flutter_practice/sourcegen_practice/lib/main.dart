import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SourceGen Demo')),
        body: Center(
          child: Text(helloUser(), style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
