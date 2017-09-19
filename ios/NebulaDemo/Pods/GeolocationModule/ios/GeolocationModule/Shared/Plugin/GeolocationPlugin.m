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

#define ERROR_CODE_GEO_LOCATION_NOT_AVALABLE    @"E10001"

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
    
    [self resolve];
}

- (void)stop
{
    GeolocationService* geoService = [Nebula serviceWithKey:SERVICE_KEY_GEOLOCATION];
    [geoService stopObserve];
    
    NBNativeEventService* nativeService = [Nebula serviceWithKey:SERVICE_KEY_NATIVEEVENT];
    [nativeService removeEvent:SERVICE_KEY_GEOLOCATION];
    
    [self resolve];
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
    [self reject:ERROR_CODE_GEO_LOCATION_NOT_AVALABLE message:@"Location Service is Not Available" data:nil];
}

@end
