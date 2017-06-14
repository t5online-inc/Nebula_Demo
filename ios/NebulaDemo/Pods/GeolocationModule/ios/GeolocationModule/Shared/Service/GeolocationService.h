//
//  GeolocationService.h
//  GeolocationModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define SERVICE_KEY_GEOLOCATION  @"geolocation"

@protocol GeolocationServiceDelegate;

@interface GeolocationService : NSObject

@property (nonatomic, assign) id<GeolocationServiceDelegate> delegate;

- (CLLocation*)getLastLocation;
- (void)startObserve:(NSTimeInterval)interval;
- (void)stopObserve;

@end


@protocol GeolocationServiceDelegate <NSObject>

- (void)geolocationService:(GeolocationService*)geolocationService updateLocation:(CLLocation*)location;
- (void)geolocationServiceNotAvailable:(GeolocationService*)geolocationService;

@end

