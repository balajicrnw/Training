import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_practice/plugin_practice.dart';
import 'package:plugin_practice/plugin_practice_platform_interface.dart';
import 'package:plugin_practice/plugin_practice_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPluginPracticePlatform
    with MockPlatformInterfaceMixin
    implements PluginPracticePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PluginPracticePlatform initialPlatform = PluginPracticePlatform.instance;

  test('$MethodChannelPluginPractice is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPluginPractice>());
  });

  test('getPlatformVersion', () async {
    PluginPractice pluginPracticePlugin = PluginPractice();
    MockPluginPracticePlatform fakePlatform = MockPluginPracticePlatform();
    PluginPracticePlatform.instance = fakePlatform;

    expect(await pluginPracticePlugin.getPlatformVersion(), '42');
  });
}
