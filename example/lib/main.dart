/*
 * @Author: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @Date: 2023-04-01 16:06:09
 * @LastEditors: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @LastEditTime: 2023-04-01 18:23:49
 * @FilePath: /speaker_switch/example/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:speaker_switch/speaker_switch.dart';
import 'package:audioplayers/audioplayers.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _speakerSwitchPlugin = SpeakerSwitch();
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _speakerSwitchPlugin.init();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _speakerSwitchPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () async{
                if (status) {
                  await _speakerSwitchPlugin.openReceiver();
                }else {
                  await _speakerSwitchPlugin.openLoudspeaker();
                }
                status = !status;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${status ? '扬声器':'听筒'}'))
                );
              },
              child: Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
            );
          }
        ),
        floatingActionButton: IconButton(icon: Icon(Icons.add) , onPressed: () async{
          audioPlayer.stop();
         final souce = (UrlSource(
          'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3'
          ));
          audioPlayer.play(souce,volume: 1, );
        }),
      ),
    );
  }
}
