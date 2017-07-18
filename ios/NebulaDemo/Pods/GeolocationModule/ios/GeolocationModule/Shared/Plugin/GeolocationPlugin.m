//
//  GeolocationPlugin.m
//  GeolocationModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "GeolocationPlugin.h"
#import "GeolocationService.h"
#import <NebulaCore/Nebula.h>
#import <NebulaCore/NSObject+Json.h>
#import <NebulaCore/NBNativeEventService.h>

#define EVENT_NAME_GEO_LOCATION @"GEOLOCATION_EVENT"

@interface GeolocationPlugin () <GeolocationServiceDelegate>

@end

@implementation GeolocationPlugin

- (void)start:(NSNumber*)interval
{
    GeolocationService* geoService = [Nebula serviceWithKey:SERVICE_KEY_GEOLOCATION];
    [geoService setDelegate:self];
    [geoService startObserve:[interval longValue]/1000.f];
    
    NBNativeEventService* nativeService = [Nebula serviceWithKey:SERVICE_KEY_NATIVEEVENT];
    [nativeService addEventWithBridgeContainer:self.bridgeContainer forKey:SERVICE_KEY_GEOLOCATION];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
    [retData setObject:@"" forKey:@"message"];
    
    [self resolve:retData];
}

- (void)stop
{
    GeolocationService* geoService = [Nebula serviceWithKey:SERVICE_KEY_GEOLOCATION];
    [geoService stopObserve];
    
    NBNativeEventService* nativeService = [Nebula serviceWithKey:SERVICE_KEY_NATIVEEVENT];
    [nativeService removeEvent:SERVICE_KEY_GEOLOCATION];
    
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
    [retData setObject:@"" forKey:@"message"];
    
    [self resolve:retData];
}

#pragma mark -
#pragma mark GeolocationServiceDelegate Methods
- (void)geolocationService:(GeolocationService *)geolocationService updateLocation:(CLLocation *)location
{
    NSDictionary* retData = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%f", location.coordinate.latitude] , @"lat",
                             [NSString stringWithFormat:@"%f", location.coordinate.longitude] , @"long",
                             nil];
    
    NBNativeEventService* nativeService = [Nebula serviceWithKey:SERVICE_KEY_NATIVEEVENT];
    [nativeService sendEventWithName:EVENT_NAME_GEO_LOCATION param:[retData jsonString] forKey:SERVICE_KEY_GEOLOCATION];
}

- (void)geolocationServiceNotAvailable:(GeolocationService *)geolocationService
{
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    [retData setObject:@(STATUS_CODE_ERROR) forKey:@"code"];
    [retData setObject:@"Location Service is Not Available" forKey:@"message"];
    
    [self resolve:retData];
//    [self reject:@"E00000" message:@"Location Service is Not Available" data:nil];
}

@end
