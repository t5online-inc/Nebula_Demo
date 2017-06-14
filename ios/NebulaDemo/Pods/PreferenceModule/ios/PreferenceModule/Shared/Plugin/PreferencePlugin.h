//
//  PreferencePlugin.h
//  PreferenceModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NebulaCore/NBPlugin.h>

#define PLUGIN_GROUP_PREFERENCE @"preference"

@interface PreferencePlugin : NBPlugin

- (void)get:(NSString*)key defaultValue:(NSString*)defaultValue;
- (void)set:(NSString*)key value:(NSString*)value;
- (void)remove:(NSString*)key;
- (void)removeAll;

@end
