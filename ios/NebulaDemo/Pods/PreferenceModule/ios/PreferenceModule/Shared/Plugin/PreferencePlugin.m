//
//  PreferencePlugin.m
//  PreferenceModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "PreferencePlugin.h"
#import <NebulaCore/Nebula.h>
#import "PreferenceService.h"

@implementation PreferencePlugin

- (void)get:(NSString*)key defaultValue:(NSString*)defaultValue
{
    NSString* ret = [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] getPreference:key defaultValue:defaultValue];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:ret forKey:@"value"];
    [self resolve:dict];
}

- (void)set:(NSString*)key value:(NSString*)value
{
    if([[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] setPreference:value forKey:key]) {
        [self resolve];
    } else {
        [self reject];
    }
}

- (void)remove:(NSString *)key
{
    if([[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removePreference:key]) {
        [self resolve];
    } else {
        [self reject];
    }
}

- (void)removeAll
{
    if([[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removeAllPreference]) {
        [self resolve];
    } else {
        [self reject];
    }
}

@end
