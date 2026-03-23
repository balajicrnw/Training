#ifndef FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_
#define FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_

#include <flutter/event_channel.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <optional>
#include <string>
#include <thread>
#include <atomic>

namespace plugin_practice {

// -----------------------------
// Time Stream using StreamHandler (Thread-Safe)
// -----------------------------
class TimePublisher {
 public:
  TimePublisher(flutter::BinaryMessenger* messenger, HWND hwnd)
      : messenger_(messenger), hwnd_(hwnd), is_running_(false) {}

  void Start(std::unique_ptr<flutter::EventSink<flutter::EncodableValue>> events);
  void Stop();

 private:
  flutter::BinaryMessenger* messenger_;
  HWND hwnd_;
  std::atomic<bool> is_running_;
  std::thread thread_;
  std::unique_ptr<flutter::EventSink<flutter::EncodableValue>> events_;
};

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

 private:
  std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>> method_channel_;
  std::unique_ptr<flutter::EventChannel<flutter::EncodableValue>> event_channel_;
  std::shared_ptr<TimePublisher> publisher_;
};

}  // namespace plugin_practice

#endif  // FLUTTER_PLUGIN_PLUGIN_PRACTICE_PLUGIN_H_
