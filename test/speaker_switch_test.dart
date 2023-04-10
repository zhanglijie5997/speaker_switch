import 'package:flutter_test/flutter_test.dart';
import 'package:speaker_switch/speaker_switch.dart';
import 'package:speaker_switch/speaker_switch_platform_interface.dart';
import 'package:speaker_switch/speaker_switch_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSpeakerSwitchPlatform
    with MockPlatformInterfaceMixin
    implements SpeakerSwitchPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SpeakerSwitchPlatform initialPlatform = SpeakerSwitchPlatform.instance;

  test('$MethodChannelSpeakerSwitch is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSpeakerSwitch>());
  });

  test('getPlatformVersion', () async {
    SpeakerSwitch speakerSwitchPlugin = SpeakerSwitch();
    MockSpeakerSwitchPlatform fakePlatform = MockSpeakerSwitchPlatform();
    SpeakerSwitchPlatform.instance = fakePlatform;

    expect(await speakerSwitchPlugin.getPlatformVersion(), '42');
  });
}
