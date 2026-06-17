import 'package:flutter/material.dart';
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
          AppChip(
            title: "Best Deal",
            appChipVariant: AppChipVariant.medium,
            iconData: Icons.bed_outlined,
          ),
        ],
      ),
    );
  }
}
