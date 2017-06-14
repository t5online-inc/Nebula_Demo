//
//  Nebula.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 22..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBPluginService.h"
#import "NBPreferenceService.h"
#import "NBGeolocationService.h"
#import "NBCustomEventService.h"

@interface Nebula : NSObject

+ (NBPluginService*)pluginService;
+ (NBPreferenceService*)preferenceService;
+ (NBGeolocationService*)geoLocationService;
+ (NBCustomEventService*)customEventService;

@end
