//
//  NBNativeEventService.h
//  NebulaCore
//
//  Created by SungJu on 2017. 6. 5..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBBridgeContainer.h"

#define SERVICE_KEY_NATIVEEVENT  @"NativeEventService"

@interface NBNativeEventService : NSObject

- (void)addEventWithBridgeContainer:(NBBridgeContainer*)container forKey:(NSString*)key;
- (void)removeEvent:(NSString*)key;
- (void)sendEventWithName:(NSString*)name param:(NSString*)param forKey:(NSString*)key;
- (void)sendEventWithName:(NSString*)name param:(NSString*)param webview:(UIWebView*)webview;

@end
