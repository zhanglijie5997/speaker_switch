/*
 * @Author: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @Date: 2023-04-01 16:06:09
 * @LastEditors: zhanglijie5997 42401363+zhanglijie5997@users.noreply.github.com
 * @LastEditTime: 2023-04-01 16:21:36
 * @FilePath: /speaker_switch/android/src/main/java/com/example/speaker_switch/SpeakerSwitchPlugin.java
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
package com.example.speaker_switch;

import android.content.Context;
import android.media.AudioManager;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/** SpeakerSwitchPlugin */
public class SpeakerSwitchPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private AudioManager audioManager;
  private static int currVolume = 0;//当前音量
  private Context cont;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    cont = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "speaker_switch");
    channel.setMethodCallHandler(this);
  }
//
//  public static void registerWith(PluginRegistry.Registrar registrar) {
//    SpeakerSwitchPlugin plugin = new SpeakerSwitchPlugin();
//    plugin.cont = registrar.context();
//  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    String method = call.method;
    switch (method) {
      case "init":
        audioManager = (AudioManager) cont.getSystemService(Context.AUDIO_SERVICE);
        Log.e("status", "初始化成功");
        break;
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "openLoudspeaker":
        if (audioManager != null) {
          try {
            audioManager.setMode(AudioManager.MODE_NORMAL);
            currVolume = audioManager.getStreamVolume(AudioManager.STREAM_SYSTEM);
            if (!audioManager.isSpeakerphoneOn()) {
              audioManager.setSpeakerphoneOn(true);
              audioManager.setStreamVolume(AudioManager.STREAM_VOICE_CALL,
                      audioManager.getStreamMaxVolume(AudioManager.STREAM_VOICE_CALL),
                      AudioManager.STREAM_VOICE_CALL);
            }
            result.success(true);
          } catch(Exception e) {
            e.printStackTrace();
            result.success(false);
          }
        }else {
          Log.e("error", "place `init`");
        }

        break;
      case "openReceiver":
        try {
          if (audioManager != null) {
            if (audioManager.isSpeakerphoneOn()) {
              Log.e("扬声器 to 听筒", "");
              audioManager.setMode(AudioManager.MODE_IN_COMMUNICATION);
              audioManager.setSpeakerphoneOn(false);
              audioManager.setStreamVolume(AudioManager.STREAM_VOICE_CALL, currVolume,AudioManager.STREAM_VOICE_CALL);
              result.success(true);
            }
          }else {
            Log.e("error", "place `init`");
          }
        } catch (Exception e) {
          result.success(false);
          e.printStackTrace();
        }
        break;
      default:
        result.notImplemented();
        break;
    }
//    if (call.method.equals("getPlatformVersion")) {
//      result.success("Android " + android.os.Build.VERSION.RELEASE);
//    } else {
//      result.notImplemented();
//    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
