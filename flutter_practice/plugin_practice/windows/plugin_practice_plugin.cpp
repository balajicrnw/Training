#include "plugin_practice_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace plugin_practice {

// static
void PluginPracticePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {

  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "plugin_practice",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<PluginPracticePlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

PluginPracticePlugin::PluginPracticePlugin() {}

PluginPracticePlugin::~PluginPracticePlugin() {}

void PluginPracticePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {

  // ✅ Existing method
  if (method_call.method_name().compare("getPlatformVersion") == 0) {

    std::ostringstream version_stream;
    version_stream << "Windows ";

    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }

    result->Success(flutter::EncodableValue(version_stream.str()));
  }

  // 🔋 Battery method (NEW)
  else if (method_call.method_name().compare("getBatteryLevel") == 0) {

    SYSTEM_POWER_STATUS status;

    if (GetSystemPowerStatus(&status)) {
      int batteryLevel = status.BatteryLifePercent;
      result->Success(flutter::EncodableValue(batteryLevel));
    } else {
      result->Error("UNAVAILABLE", "Battery info not available");
    }
  }


  else {
    result->NotImplemented();
  }
}

}  