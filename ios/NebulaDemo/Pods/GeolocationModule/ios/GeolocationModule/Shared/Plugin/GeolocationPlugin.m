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

@interface GeolocationPlugin () <GeolocationServiceDelegate>

@end

@implementation GeolocationPlugin

- (void)get:(NSNumber*)interval
{
    GeolocationService* geoService = [Nebula serviceWithKey:SERVICE_KEY_GEOLOCATION];
    [geoService setDelegate:self];
    [geoService startObserve:interval.longValue/1000.f];
}

#pragma mark -
#pragma mark GeolocationServiceDelegate Methods
- (void)geolocationService:(GeolocationService *)geolocationService updateLocation:(CLLocation *)location
{
    NSMutableDictionary* locationDic = [NSMutableDictionary new];
    [locationDic setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
    [locationDic setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"long"];
    [self resolve:locationDic];
}

- (void)geolocationServiceNotAvailable:(GeolocationService *)geolocationService
{
    [self reject:@"E00000" message:@"Location Service is Not Available" data:nil];
}

@end
