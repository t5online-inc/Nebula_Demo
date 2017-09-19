//
//  BioAuthenticationPlugin.m
//  BioAuthenticationModule
//
//  Created by Hyunjun Kwak on 2017. 6. 20..
//  Copyright © 2017년 Hyunjun Kwak. All rights reserved.
//

#import "BioAuthenticationPlugin.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define kLAErrorUnsupportedDevice   -99

#define ERROR_CODE_BIO_AUTH_NOT_AVAILABLE   @"E10001"
#define ERROR_CODE_BIO_AUTH_FAIL            @"E10002"

@implementation BioAuthenticationPlugin

/**
 isSupported
 */
- (void)isSupported {
    Class laContaxtClass = NSClassFromString(@"LAContext");
    
    if (laContaxtClass) {
        NSError* error = nil;
        LAContext* laContext = [[LAContext alloc] init];
        BOOL isAvailable = [laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        
        if (isAvailable) {
            [self resolve];
        } else {
            NSString* message = [self authenticationErrorMessage:[error code]];
            [self reject:ERROR_CODE_BIO_AUTH_NOT_AVAILABLE message:message data:nil];
        }
    } else {
        NSString* message = [self authenticationErrorMessage:kLAErrorUnsupportedDevice];
        [self reject:ERROR_CODE_BIO_AUTH_NOT_AVAILABLE message:message data:nil];
    }
}

/**
 authenticate:

 @param message Localized Reason Message
 */
- (void)authenticate:(NSString *)message {
    [self authenticate:message cancelTitle:nil fallbackTitle:nil];
}

/**
 authenticate:cancelTitle:fallbackTitle:

 @param message Localized Reason Message
 @param cancel Localized Cancel Button Title
 @param fallback Localized Fallback Button Title
 */
- (void)authenticate:(NSString*)message cancelTitle:(NSString*)cancel fallbackTitle:(NSString*)fallback {
//    [self startAuthenticationLaPolicy:LAPolicyDeviceOwnerAuthentication withMessage:message cancelTitle:cancel fallbackTitle:fallback];
    [self authenticateLaPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics withMessage:message cancelTitle:cancel fallbackTitle:fallback];
}

/**
 authenticateCustomPassCode:

 @param message Localized Reason Message
 */
- (void)authenticateCustomPassCode:(NSString*)message {
    [self authenticateCustomPassCode:message cancelTitle:nil fallbackTitle:nil];
}

/**
 authenticateCustomPassCode:cancelTitle:fallbackTitle

 @param message Localized Reason Message
 @param cancel Localized Cancel Button Title
 @param fallback Localized Fallback Button Title
 */
- (void)authenticateCustomPassCode:(NSString*)message cancelTitle:(NSString*)cancel fallbackTitle:(NSString*)fallback {
    [self authenticateLaPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics withMessage:message cancelTitle:cancel fallbackTitle:fallback];
}

/**
 authenticateLaPolicy:withMessage:cancelTitle:fallbackTitle

 @param policy LAPolicy
 @param message Localized Reason Message
 @param cancel Localized Cancel Button Title
 @param fallback Localized Fallback Button Title
 */
- (void)authenticateLaPolicy:(LAPolicy)policy withMessage:(NSString *)message cancelTitle:(NSString*)cancel fallbackTitle:(NSString*)fallback  {
    Class laContaxtClass = NSClassFromString(@"LAContext");
    
    if (laContaxtClass) {
        NSError* error = nil;
        LAContext* laContext = [[LAContext alloc] init];
        BOOL isAvailable = [laContext canEvaluatePolicy:policy error:&error];
        
        if (cancel) {
            [laContext setLocalizedCancelTitle:cancel];
        }
        
        if (fallback) {
            [laContext setLocalizedFallbackTitle:fallback];
        }
        
        if (isAvailable) {
            [laContext evaluatePolicy:policy localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    [self resolve];
                } else {
                    NSString* message = [self authenticationErrorMessage:[error code]];
                    [self reject:ERROR_CODE_BIO_AUTH_FAIL message:message data:nil];
                }
            }];
        } else {
            NSString* message = [self authenticationErrorMessage:[error code]];
            [self reject:ERROR_CODE_BIO_AUTH_FAIL message:message data:nil];
        }
    } else {
        NSString* message = [self authenticationErrorMessage:kLAErrorUnsupportedDevice];
        [self reject:ERROR_CODE_BIO_AUTH_FAIL message:message data:nil];
    }
}

#pragma mark -

/**
 authenticationErrorMessage

 @param code ErrorCode
 @return ErrorMessage
 */
- (NSString*)authenticationErrorMessage:(NSInteger)code {
    switch (code) {
        case kLAErrorAuthenticationFailed:
            return @"authenticationFailed";
            
        case kLAErrorUserCancel:
            return @"userCancel";
            
        case kLAErrorUserFallback:
            return @"userFallback";
            
        case kLAErrorSystemCancel:
            return @"systemCancel";
            
        case kLAErrorPasscodeNotSet:
            return @"passcodeNotSet";
            
        case kLAErrorTouchIDNotAvailable:
            return @"touchIDNotAvailable";
            
        case kLAErrorTouchIDNotEnrolled:
            return @"touchIDNotEnrolled";
            
        case kLAErrorTouchIDLockout:
            return @"touchIDLockout";
            
        case kLAErrorAppCancel:
            return @"appCancel";
            
        case kLAErrorUnsupportedDevice:
            return @"unsupportedDevice";
    }
    
    return @"unknown";
}

@end
