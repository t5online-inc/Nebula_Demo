//
//  NBGeolocationService.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 26..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol NBGeolocationServiceDelegate;

@interface NBGeolocationService : NSObject

@property (nonatomic, weak) id<NBGeolocationServiceDelegate> delegate;

- (CLLocation*)getLastLocation;
- (void)startObserve:(NSTimeInterval)interval;
- (void)stopObserve;

@end


@protocol NBGeolocationServiceDelegate <NSObject>

- (void)geolocationService:(NBGeolocationService*)geolocationService updateLocation:(CLLocation*)location;
- (void)geolocationServiceNotAvailable:(NBGeolocationService*)geolocationService;

@end
