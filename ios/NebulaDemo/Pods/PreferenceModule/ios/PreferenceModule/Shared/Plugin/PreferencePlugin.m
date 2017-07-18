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
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
    [retData setObject:ret forKey:@"message"];
    
    [self resolve:retData];
}

- (void)set:(NSString*)key value:(NSString*)value
{
    BOOL isSuccess = [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] setPreference:value forKey:key];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(isSuccess ? STATUS_CODE_SUCCESS : STATUS_CODE_ERROR) forKey:@"code"];
    [retData setObject:@"" forKey:@"message"];
    
    [self resolve:retData];
}

- (void)remove:(NSString *)key
{
    BOOL isSuccess = [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removePreference:key];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(isSuccess ? STATUS_CODE_SUCCESS : STATUS_CODE_ERROR) forKey:@"code"];
    [retData setObject:@"" forKey:@"message"];
    
    [self resolve:retData];
}

- (void)removeAll
{
    BOOL isSuccess = [[Nebula serviceWithKey:SERVICE_KEY_PREFERENCE] removeAllPreference];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(isSuccess ? STATUS_CODE_SUCCESS : STATUS_CODE_ERROR) forKey:@"code"];
    [retData setObject:@"" forKey:@"message"];
    
    [self resolve:retData];
}

@end
