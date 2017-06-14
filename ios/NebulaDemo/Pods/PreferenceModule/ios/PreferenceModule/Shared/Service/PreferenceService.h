//
//  PreferenceService.h
//  PreferenceModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVICE_KEY_PREFERENCE  @"preferenceService"

@interface PreferenceService : NSObject

- (BOOL)setPreference:(NSString*)value forKey:(NSString*)key;
- (NSString*)getPreference:(NSString*)key;
- (NSString*)getPreference:(NSString*)key defaultValue:(NSString*)defaultValue;
- (BOOL)removePreference:(NSString*)key;
- (BOOL)removeAllPreference;

@end
