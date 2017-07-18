//
//  ScreenShotPlugin.h
//  ScreenShotModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NebulaCore/NBPlugin.h>

#define PLUGIN_GROUP_SCREENSHOT @"screenshot"

@interface ScreenShotPlugin : NBPlugin

- (void)takePicture;

@end
