import 'package:flutter/services.dart';

class PluginPractice {
  static const MethodChannel _channel = MethodChannel('plugin_practice');
  static const EventChannel _timeEventChannel = EventChannel('plugin_practice/timeStream');

  /// 🔋 Get battery level (one-time)
  Future<int?> getBatteryLevel() async {
    try {
      final int? battery = await _channel.invokeMethod<int>('getBatteryLevel');
      return battery;
    } on PlatformException catch (e) {
      print("Failed to get battery level: ${e.message}");
      return null;
    }
  }

  /// 💻 Get platform version (one-time)
  Future<String?> getPlatformVersion() async {
    try {
      final String? version = await _channel.invokeMethod<String>('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      print("Failed to get platform version: ${e.message}");
      return null;
    }
  }

  /// 💡 Enable battery saver (opens settings)
  Future<void> enableBatterySaver() async {
    try {
      await _channel.invokeMethod('enableBatterySaver');
    } on PlatformException catch (e) {
      print("Failed to enable battery saver: ${e.message}");
    }
  }

  Stream<String>? get timeStream {
    return _timeEventChannel.receiveBroadcastStream().map<String>((event) => event as String);
  }
}