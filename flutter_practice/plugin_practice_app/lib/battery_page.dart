import 'package:flutter/material.dart';
import 'package:plugin_practice/plugin_practice.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final plugin = PluginPractice();
  String batteryText = "Press button to get battery";

  Future<void> getBattery() async {
    final battery = await plugin.getBatteryLevel();

    setState(() {
      batteryText = battery != null
          ? "Battery: $battery%"
          : "Failed to get battery";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Battery Plugin")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              batteryText,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getBattery,
              child: const Text("Get Battery"),
            ),
          ],
        ),
      ),
    );
  }
}