import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/app_bottom_navigator.dart';
import 'ui.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
          ),
          AppBottomNavigator(),
        ],
      ),
    );
  }
}
