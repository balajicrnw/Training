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
  String statusText = "";
  String currentTime = "Fetching current time...";

  @override
  void initState() {
    super.initState();
    // Listen to the time stream
    plugin.timeStream?.listen((time) {
      setState(() {
        currentTime = time;
      });
    });
  }

  // 🔋 Get battery level once
  Future<void> getBattery() async {
    final battery = await plugin.getBatteryLevel();
    setState(() {
      batteryText = battery != null ? "Battery: $battery%" : "Failed to get battery";
    });
  }

  // 💡 Open battery saver settings
  Future<void> enableBatterySaver() async {
    try {
      await plugin.enableBatterySaver();
      setState(() {
        statusText = "Opened Battery Saver settings. Please enable it manually.";
      });
    } catch (e) {
      setState(() {
        statusText = "Failed to open Battery Saver settings: $e";
      });
    }
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
              child: const Text("Get Battery Level"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: enableBatterySaver,
              child: const Text("Enable Battery Saver"),
            ),
            const SizedBox(height: 20),
            Text(
              statusText,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // ⏱ Current Time
            Text(
              "Current Time: $currentTime",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}