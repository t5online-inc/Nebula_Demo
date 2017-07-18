//
//  NBPluginService.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NBPlugin.h"
#import "NBBridgeContainer.h"

#define SERVICE_KEY_PLUGIN  @"PluginService"

@interface NBPluginService : NSObject

- (void)addPlugin:(NBPlugin*)plugin actionGroup:(NSString*)group;
- (void)addPluginClass:(NSString*)pluginClass actionGroup:(NSString*)group;
- (void)proceedJsRequest:(NBBridgeContainer*)bridgeContainer;

@end
