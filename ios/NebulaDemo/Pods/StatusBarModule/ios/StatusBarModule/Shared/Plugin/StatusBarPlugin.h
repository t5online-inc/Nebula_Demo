//
//  StatusBarPlugin.h
//  StatusBarModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NebulaCore/NBPlugin.h>

#define PLUGIN_GROUP_STATUSBAR @"statusbar"

@interface StatusBarPlugin : NBPlugin

- (void)setStatusBar:(NSNumber*)isHidden backgroundColor:(NSString*)backgroundColor isDefault:(NSNumber*)isDefault;

@end
