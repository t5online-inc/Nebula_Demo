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

#define ERROR_CODE_INVALID_KEY      @"E10001"
#define ERROR_CODE_INVALID_VALUE    @"E10002"
#define ERROR_CODE_INVALID_DATA     @"E10003"

@implementation PreferencePlugin

- (void)get:(NSString*)key defaultValue:(NSString*)defaultValue
{
    if (!key) {
        [self reject:ERROR_CODE_INVALID_KEY message:@"Invalid Key" data:nil];
        return;
    }
    
    NSString* ret = [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] getPreference:key defaultValue:defaultValue];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:ret forKey:@"value"];
    [self resolve:retData];
    
}

- (void)set:(NSString*)key value:(NSString*)value
{
    if (!key) {
        [self reject:ERROR_CODE_INVALID_KEY message:@"Invalid Key" data:nil];
        return;
    }
    
    if (!value) {
        [self reject:ERROR_CODE_INVALID_VALUE message:@"Invalid Value" data:nil];
        return;
    }
    
    [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] setPreference:value forKey:key];
    [self resolve];
}

- (void)remove:(NSString *)key
{
    if (!key) {
        [self reject:ERROR_CODE_INVALID_KEY message:@"Invalid Key" data:nil];
        return;
    }
    
    [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removePreference:key];
    [self resolve];
}

- (void)removeAll
{
    [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removeAllPreference];
    [self resolve];
}

@end
