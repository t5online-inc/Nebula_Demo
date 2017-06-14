//
//  PreferenceService.m
//  PreferenceModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "PreferenceService.h"

@implementation PreferenceService

- (BOOL)setPreference:(NSString*)value forKey:(NSString*)key
{
    if (!key || !value) return NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
    return YES;
}

- (NSString*)getPreference:(NSString*)key
{
    return [self getPreference:key defaultValue:nil];
}

- (NSString *)getPreference:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* ret = [userDefaults objectForKey:key];
    if (ret) return ret;
    return defaultValue;
}

- (BOOL)removePreference:(NSString*)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
    return YES;
}

- (BOOL)removeAllPreference
{
    [NSUserDefaults resetStandardUserDefaults];
    return YES;
}

@end
