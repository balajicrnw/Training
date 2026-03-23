#include "include/plugin_practice/plugin_practice_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "plugin_practice_plugin.h"

void PluginPracticePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  plugin_practice::PluginPracticePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
