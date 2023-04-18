/*
 * @Author: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @Date: 2023-04-01 16:06:09
 * @LastEditors: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @LastEditTime: 2023-04-01 18:05:18
 * @FilePath: /speaker_switch/lib/speaker_switch.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'speaker_switch_platform_interface.dart';

class SpeakerSwitch {
  Future<String?> getPlatformVersion() {
    return SpeakerSwitchPlatform.instance.getPlatformVersion();
  }

  Future<bool?> openLoudspeaker() {
    return SpeakerSwitchPlatform.instance.openLoudspeaker();
  }
  Future<bool?> openReceiver() {
    return SpeakerSwitchPlatform.instance.openReceiver();
  }
  Future<bool?> isOpenLoudspeaker() {
    return SpeakerSwitchPlatform.instance.isOpenLoudspeaker();
  }

  Future<void> init() async{
    SpeakerSwitchPlatform.instance.init();
  }
}
