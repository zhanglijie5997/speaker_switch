#ifndef FLUTTER_PLUGIN_SPEAKER_SWITCH_PLUGIN_H_
#define FLUTTER_PLUGIN_SPEAKER_SWITCH_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace speaker_switch {

class SpeakerSwitchPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SpeakerSwitchPlugin();

  virtual ~SpeakerSwitchPlugin();

  // Disallow copy and assign.
  SpeakerSwitchPlugin(const SpeakerSwitchPlugin&) = delete;
  SpeakerSwitchPlugin& operator=(const SpeakerSwitchPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace speaker_switch

#endif  // FLUTTER_PLUGIN_SPEAKER_SWITCH_PLUGIN_H_
