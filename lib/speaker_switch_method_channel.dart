/*
 * @Author: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @Date: 2023-04-01 16:06:09
 * @LastEditors: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @LastEditTime: 2023-04-01 17:40:20
 * @FilePath: /speaker_switch/lib/speaker_switch_method_channel.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'speaker_switch_platform_interface.dart';

/// An implementation of [SpeakerSwitchPlatform] that uses method channels.
class MethodChannelSpeakerSwitch extends SpeakerSwitchPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('speaker_switch');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> openLoudspeaker() async{
    final result = await methodChannel.invokeMethod<bool>('openLoudspeaker');
    return result;
  }
  @override
  Future<bool?> openReceiver() async{
    final result = await methodChannel.invokeMethod<bool>('openReceiver');
    return result;
  }

  @override
  Future<void> init() async{
    await methodChannel.invokeMethod<void>('init');
    
  }
}
