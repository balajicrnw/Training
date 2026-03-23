#ifndef FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_
#define FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <optional>

namespace plugin_practice {

class PluginPracticePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PluginPracticePlugin();

  virtual ~PluginPracticePlugin();

  // Disallow copy and assign.
  PluginPracticePlugin(const PluginPracticePlugin&) = delete;
  PluginPracticePlugin& operator=(const PluginPracticePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  // Called for top-level window messages.
  std::optional<LRESULT> HandleWindowMessage(HWND hwnd, UINT message,
                                              WPARAM wparam, LPARAM lparam);
};

}  // namespace plugin_practice

#endif  // FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_
