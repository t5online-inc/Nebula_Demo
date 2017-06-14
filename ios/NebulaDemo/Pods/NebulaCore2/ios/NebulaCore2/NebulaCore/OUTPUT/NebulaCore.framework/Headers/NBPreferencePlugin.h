//
//  NBPreferencePlugin.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "NBPlugin.h"
#import "NBPluginResult.h"

@interface NBPreferencePlugin : NBPlugin

- (void)get:(NSString*)key defaultValue:(NSString*)defaultValue;
- (void)set:(NSString*)key value:(NSString*)value;
- (void)remove:(NSString*)key;
- (void)removeAll;

@end
