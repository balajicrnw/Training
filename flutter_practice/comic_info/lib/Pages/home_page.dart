import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Router/router_names.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child:Column( children: [
          const Text("Get Information about Comic characters here"),
          ElevatedButton(
              onPressed: () {
                context.goNamed(RouterNames.characters);
                print("Go to Characters");
              },
              child: const Text("Go to Characters"))
          ],
        ),
      ),
    );
  }
}