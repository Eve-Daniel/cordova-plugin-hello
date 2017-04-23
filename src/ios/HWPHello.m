#import "HWPHello.h"
#import <Cordova/CDVAvailability.h>

@implementation HWPHello

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate evalJs:@"alert('aaapjpjpjpj')"];
    [self observeLifeCycle];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

- (void) observeLifeCycle
{
    NSNotificationCenter* listener = [NSNotificationCenter
                                      defaultCenter];

        [listener addObserver:self
                     selector:@selector(handleAudioSessionInterruption:)
                         name:AVAudioSessionInterruptionNotification
                       object:nil];
             
    [self.commandDelegate evalJs:@"alert('foo-install')"];
}

- (void) handleAudioSessionInterruption:(NSNotification*)notification{
    
}

@end
