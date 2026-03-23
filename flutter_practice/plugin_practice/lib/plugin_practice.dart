import 'package:flutter/services.dart';

class PluginPractice {
  // ✅ Channel name must match Android & Windows
  static const MethodChannel _channel =
      MethodChannel('plugin_practice');

  /// 🔋 Get Battery Level (works on Android + Windows)
  Future<int?> getBatteryLevel() async {
    try {
      final int? battery =
          await _channel.invokeMethod<int>('getBatteryLevel');
      return battery;
    } on PlatformException catch (e) {
      print("Failed to get battery level: ${e.message}");
      return null;
    }
  }

  /// 💻 Optional: Get Platform Version (Windows example)
  Future<String?> getPlatformVersion() async {
    try {
      final String? version =
          await _channel.invokeMethod<String>('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      print("Failed to get platform version: ${e.message}");
      return null;
    }
  }
}