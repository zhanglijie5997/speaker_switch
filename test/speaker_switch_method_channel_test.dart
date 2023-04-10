import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speaker_switch/speaker_switch_method_channel.dart';

void main() {
  MethodChannelSpeakerSwitch platform = MethodChannelSpeakerSwitch();
  const MethodChannel channel = MethodChannel('speaker_switch');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
