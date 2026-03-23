#include "plugin_practice_plugin.h"

#include <windows.h>
#include <shellapi.h>
#include <VersionHelpers.h>
#include <commctrl.h>
#pragma comment(lib, "comctl32.lib")

#include <flutter/event_channel.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <chrono>
#include <ctime>
#include <thread>
#include <atomic>
#include <iostream>

#include <functional>

static UINT WM_FLUTTER_TASK = 0;

namespace plugin_practice {


// -----------------------------
// Time Stream using StreamHandlerFunctions (True Thread-Safe)
// -----------------------------
// -----------------------------
// TimePublisher Implementation
// -----------------------------
void TimePublisher::Start(std::unique_ptr<flutter::EventSink<flutter::EncodableValue>> events) {
  if (is_running_) Stop();

  events_ = std::move(events);
  is_running_ = true;

  thread_ = std::thread([this]() {
    while (is_running_) {
      std::time_t t = std::time(nullptr);
      char buffer[100];
      std::tm timeinfo;
      localtime_s(&timeinfo, &t);
      std::strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", &timeinfo);

      std::string time_str(buffer);

      // Post task to platform thread
      auto task = new std::function<void()>([this, time_str]() {
        if (events_) {
          events_->Success(flutter::EncodableValue(time_str));
        }
      });

      if (!PostMessage(hwnd_, WM_FLUTTER_TASK, 0, (LPARAM)task)) {
        delete task;
      }

      std::this_thread::sleep_for(std::chrono::seconds(1));
    }
  });
}

void TimePublisher::Stop() {
  is_running_ = false;
  if (thread_.joinable()) thread_.join();
  events_ = nullptr;
}

// -----------------------------
// Register Plugin
// -----------------------------
void PluginPracticePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  if (WM_FLUTTER_TASK == 0) {
    WM_FLUTTER_TASK = RegisterWindowMessage(L"PluginPracticeTask");
  }

  auto plugin = std::make_unique<PluginPracticePlugin>();
  HWND hwnd = registrar->GetView()->GetNativeWindow();

  // Method channel
  plugin->method_channel_ = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      registrar->messenger(), "plugin_practice",
      &flutter::StandardMethodCodec::GetInstance());

  plugin->method_channel_->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const flutter::MethodCall<flutter::EncodableValue>& call,
                                     std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  // Event channel for time
  const std::string time_channel_name = "plugin_practice/timeStream";
  plugin->event_channel_ = std::make_unique<flutter::EventChannel<flutter::EncodableValue>>(
      registrar->messenger(), time_channel_name,
      &flutter::StandardMethodCodec::GetInstance());

  plugin->publisher_ = std::make_shared<TimePublisher>(registrar->messenger(), hwnd);

  auto publisher = plugin->publisher_;
  plugin->event_channel_->SetStreamHandler(std::make_unique<
      flutter::StreamHandlerFunctions<flutter::EncodableValue>>(
      [publisher](const flutter::EncodableValue* arguments,
                  std::unique_ptr<flutter::EventSink<flutter::EncodableValue>>&& events)
          -> std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> {
        publisher->Start(std::move(events));
        return nullptr;
      },
      [publisher](const flutter::EncodableValue* arguments)
          -> std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> {
        publisher->Stop();
        return nullptr;
      }));

  auto plugin_ptr = plugin.get();
  registrar->AddPlugin(std::move(plugin));

  SetWindowSubclass(hwnd, [](HWND hwnd, UINT msg, WPARAM wp, LPARAM lp, UINT_PTR id, DWORD_PTR data) -> LRESULT {
    auto plugin = reinterpret_cast<PluginPracticePlugin*>(data);
    auto result = plugin->HandleWindowMessage(hwnd, msg, wp, lp);
    if (result.has_value()) return result.value();
    return DefSubclassProc(hwnd, msg, wp, lp);
  }, 1, (DWORD_PTR)plugin_ptr);
}

// -----------------------------
// Constructor / Destructor
// -----------------------------
PluginPracticePlugin::PluginPracticePlugin() {}
PluginPracticePlugin::~PluginPracticePlugin() {}

// -----------------------------
// Handle Method Calls
// -----------------------------
void PluginPracticePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {

  if (method_call.method_name() == "getPlatformVersion") {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) version_stream << "10+";
    else if (IsWindows8OrGreater()) version_stream << "8";
    else if (IsWindows7OrGreater()) version_stream << "7";
    result->Success(flutter::EncodableValue(version_stream.str()));
  }

  else if (method_call.method_name() == "getBatteryLevel") {
    SYSTEM_POWER_STATUS status;
    if (GetSystemPowerStatus(&status)) {
      result->Success(flutter::EncodableValue(status.BatteryLifePercent));
    } else {
      result->Error("UNAVAILABLE", "Battery info not available");
    }
  }

  else if (method_call.method_name() == "enableBatterySaver") {
    HINSTANCE hInst = ShellExecute(nullptr, L"open", L"ms-settings:batterysaver", nullptr, nullptr, SW_SHOWNORMAL);
    if ((intptr_t)hInst > 32) {
      result->Success(flutter::EncodableValue(true));
    } else {
      result->Error("UNAVAILABLE", "Unable to open Battery Saver settings");
    }
  }

  else {
    result->NotImplemented();
  }
}

std::optional<LRESULT> PluginPracticePlugin::HandleWindowMessage(
    HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) {
  if (message == WM_FLUTTER_TASK) {
    auto task = reinterpret_cast<std::function<void()>*>(lparam);
    (*task)();
    delete task;
    return 0;
  }
  return std::nullopt;
}
}  // namespace plugin_practice
