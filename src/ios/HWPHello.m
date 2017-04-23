#import "HWPHello.h"
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVAvailability.h>

@implementation HWPHello

- (void)greet:(CDVInvokedUrlCommand*)command{

    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];    
    [self observeLifeCycle];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

- (void) observeLifeCycle{
    NSNotificationCenter* listener = [NSNotificationCenter
                                      defaultCenter];

        [listener addObserver:self
                     selector:@selector(handleAudioSessionInterruption:)
                         name:AVAudioSessionInterruptionNotification
                       object:nil];
             
    //[self.commandDelegate evalJs:@"alert('foo-install')"];
}

- (void) handleAudioSessionInterruption:(NSNotification*)notification{
    int interruptionType = [notification.userInfo[AVAudioSessionInterruptionTypeKey] intValue];
    if (interruptionType == AVAudioSessionInterruptionTypeBegan) {
         [self.commandDelegate evalJs:@"try{window.Eve.APP().onPause();}catch(e){alert(e.message);}"];
    } else if (interruptionType == AVAudioSessionInterruptionTypeEnded) {
        if ([notification.userInfo[AVAudioSessionInterruptionOptionKey] intValue] == AVAudioSessionInterruptionOptionShouldResume) {
         [self.commandDelegate evalJs:@"try{window.Eve.APP().onResume();}catch(e){alert(e.message);}"];
        }        
    }
}

@end
