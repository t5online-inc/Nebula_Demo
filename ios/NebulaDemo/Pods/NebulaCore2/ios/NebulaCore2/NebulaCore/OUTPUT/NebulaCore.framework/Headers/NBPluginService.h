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

#define PLUGIN_GROUP_PREFERENCE     @"preference"
#define PLUGIN_GROUP_DEVICEINFO     @"deviceinfo"
#define PLUGIN_GROUP_SCREENSHOT     @"screenshot"
#define PLUGIN_GROUP_FILESYSTEM     @"filesystem"
#define PLUGIN_GROUP_NATIVEEVENT    @"nativeevent"
#define PLUGIN_GROUP_GEOLOCATION    @"geolocation"
#define PLUGIN_GROUP_STATUSBAR      @"statusbar"


@interface NBPluginService : NSObject

- (void)addPlugin:(NSObject*)plugin actionGroup:(NSString*)group;
- (void)addPluginClass:(NSString*)pluginClass actionGroup:(NSString*)group;
- (void)proceedJsRequest:(NBBridgeContainer*)bridgeContainer;

@end
