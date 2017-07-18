//
//  DeviceInfoPlugin.m
//  DeviceInfoModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "DeviceInfoPlugin.h"
#import "KeychainItemWrapper.h"

@implementation DeviceInfoPlugin

- (void)getDeviceInfo
{
    NSString* phoneName     = [[UIDevice currentDevice] name];
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString* platformName  = @"iOS";
    NSString* modelName = [[UIDevice currentDevice] model];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appVer = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString* buildNo = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString* appName = [infoDictionary objectForKey:@"CFBundleName"];
    NSString* deviceId = [self getDeviceId];
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          phoneName, @"phoneName",
                          platformName, @"platform",
                          systemVersion, @"platformVersion",
                          appName, @"appName",
                          modelName, @"modelName",
                          appVer, @"appVersion",
                          buildNo, @"appBuildNo",
                          deviceId, @"deviceId",
                          nil];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
    [retData setObject:dict forKey:@"message"];
    
    [self resolve:retData];
}

- (NSString*)getDeviceId
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
    NSString *uuid = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    if( uuid == nil || uuid.length == 0)
    {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [wrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
    }
    
    return uuid;
}

@end
