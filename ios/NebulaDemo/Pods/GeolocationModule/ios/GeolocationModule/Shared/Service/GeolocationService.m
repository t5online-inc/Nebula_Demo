//
//  GeolocationService.m
//  GeolocationModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "GeolocationService.h"

@interface GeolocationService () <CLLocationManagerDelegate>
{
    NSTimeInterval _timeInterval;
    NSDate* _lastReturnDate;
    BOOL _observing;
}
@property (nonatomic, strong) CLLocationManager* locationManager;
@end

@implementation GeolocationService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initLocationManager];
    }
    return self;
}

- (void)initLocationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (CLLocation *)getLastLocation {
    if (_locationManager) {
        return _locationManager.location;
    }
    return nil;
}

- (void)startObserve:(NSTimeInterval)interval
{
    _timeInterval = interval; // millisecond
    _observing = YES;
    if (_locationManager) {
        BOOL isAvaliable = NO;
        if ([CLLocationManager locationServicesEnabled]) {
            int status = [CLLocationManager authorizationStatus];
            switch(status) {
                case kCLAuthorizationStatusNotDetermined:
                    NSLog(@"kCLAuthorizationStatusNotDetermined");
                    [_locationManager requestWhenInUseAuthorization];
                    return;
                case kCLAuthorizationStatusRestricted:
                    NSLog(@"kCLAuthorizationStatusRestricted");
                    break;
                case kCLAuthorizationStatusDenied:
                    NSLog(@"kCLAuthorizationStatusDenied");
                    break;
                case kCLAuthorizationStatusAuthorizedAlways:
                    NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
                    isAvaliable = YES;
                    break;
                case kCLAuthorizationStatusAuthorizedWhenInUse:
                    NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
                    isAvaliable = YES;
                    break;
            }
        }
        
        if (isAvaliable) {
            if (_timeInterval <= 0) {
                [_locationManager requestLocation];
            } else {
                [_locationManager startUpdatingLocation];
            }
        } else {
            if ([_delegate respondsToSelector:@selector(geolocationServiceNotAvailable:)]) {
                [_delegate geolocationServiceNotAvailable:self];
            }
        }
    }
}

- (void)stopObserve
{
    _observing = NO;
    _lastReturnDate = nil;
    _timeInterval = 0;
    
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
    }
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (ABS(howRecent) < 15.0) { // 최근 데이터 확인
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        
        if (_lastReturnDate == nil || [eventDate timeIntervalSinceDate:_lastReturnDate] >= _timeInterval) {
            if ([_delegate respondsToSelector:@selector(geolocationService:updateLocation:)]) {
                [_delegate geolocationService:self updateLocation:location];
            }
            _lastReturnDate = eventDate;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
    if ([_delegate respondsToSelector:@selector(geolocationServiceNotAvailable:)]) {
        [_delegate geolocationServiceNotAvailable:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (_observing) {
        [self startObserve:_timeInterval];
    }
}

@end
