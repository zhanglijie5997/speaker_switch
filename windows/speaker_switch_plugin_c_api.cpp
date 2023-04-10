#include "include/speaker_switch/speaker_switch_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "speaker_switch_plugin.h"

void SpeakerSwitchPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  speaker_switch::SpeakerSwitchPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
