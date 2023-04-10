#import "SpeakerSwitchPlugin.h"
#import <AVFoundation/AVFoundation.h>
@implementation SpeakerSwitchPlugin

AVAudioSession *session;
AVAudioSessionRouteDescription *currentRoute ;
AVAudioSessionPortDescription *outputPort;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"speaker_switch"
            binaryMessenger:[registrar messenger]];
  SpeakerSwitchPlugin* instance = [[SpeakerSwitchPlugin alloc] init];
    session = [AVAudioSession sharedInstance];
    currentRoute = session.currentRoute;
    outputPort = currentRoute.outputs.firstObject;
    
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
 NSError *setCategoryError = nil;
 NSError *overrideOutputAudioPortError = nil;
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"openLoudspeaker" isEqualToString:call.method]) {
      [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:&overrideOutputAudioPortError];
    NSLog(@"扬声器切换成功");
      if ([outputPort.portType isEqualToString:AVAudioSessionPortBuiltInSpeaker]) {
          // The audio output is set to speaker mode
          NSLog(@"Audio output mode: 扬声器");
      } else if ([outputPort.portType isEqualToString:AVAudioSessionPortBuiltInReceiver]) {
          // The audio output is set to receiver mode
          NSLog(@"Audio output mode: 听筒");
      } else {
          // The audio output is set to an unknown mode
          NSLog(@"Audio output mode: Unknown");
      }
    result([NSNumber numberWithBool:YES]);
  } else if ([@"openReceiver" isEqualToString:call.method]) {
      [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:&overrideOutputAudioPortError];
      
      
    NSLog(@"听筒切换成功");
      
      if ([outputPort.portType isEqualToString:AVAudioSessionPortBuiltInSpeaker]) {
          // The audio output is set to speaker mode
          NSLog(@"Audio output mode: 扬声器");
      } else if ([outputPort.portType isEqualToString:AVAudioSessionPortBuiltInReceiver]) {
          // The audio output is set to receiver mode
          NSLog(@"Audio output mode: 听筒");
      } else {
          // The audio output is set to an unknown mode
          NSLog(@"Audio output mode: Unknown");
      }
    result([NSNumber numberWithBool:YES]);
  }
//   else if([@"openLoudspeaker" isEqualToString:call.method]) {
//         result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
// 
//   } else if([@"openLoudspeaker" isEqualToString:call.method]) {
//     
//         result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
// 
//   }
  else {
    result(FlutterMethodNotImplemented);
  }
}


@end
