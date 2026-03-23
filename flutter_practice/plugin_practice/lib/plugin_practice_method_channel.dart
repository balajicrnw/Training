import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plugin_practice_platform_interface.dart';

/// An implementation of [PluginPracticePlatform] that uses method channels.
class MethodChannelPluginPractice extends PluginPracticePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_practice');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
