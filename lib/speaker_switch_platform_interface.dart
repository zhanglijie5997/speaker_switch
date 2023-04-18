import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'speaker_switch_method_channel.dart';

abstract class SpeakerSwitchPlatform extends PlatformInterface {
  /// Constructs a SpeakerSwitchPlatform.
  SpeakerSwitchPlatform() : super(token: _token);

  static final Object _token = Object();

  static SpeakerSwitchPlatform _instance = MethodChannelSpeakerSwitch();

  /// The default instance of [SpeakerSwitchPlatform] to use.
  ///
  /// Defaults to [MethodChannelSpeakerSwitch].
  static SpeakerSwitchPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SpeakerSwitchPlatform] when
  /// they register themselves.
  static set instance(SpeakerSwitchPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> openLoudspeaker() {
    throw UnimplementedError('openLoudspeaker() has not been implemented.');
  }
  Future<bool?> openReceiver() {
    throw UnimplementedError('openReceiver() has not been implemented.');
  }
  Future<bool?> isOpenLoudspeaker() {
    throw UnimplementedError('openReceiver() has not been implemented.');
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }
}
