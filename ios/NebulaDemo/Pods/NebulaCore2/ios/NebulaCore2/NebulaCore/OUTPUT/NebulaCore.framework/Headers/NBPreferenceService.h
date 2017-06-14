//
//  NBPreferenceService.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 23..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBPreferenceService : NSObject

- (BOOL)setPreference:(NSString*)value forKey:(NSString*)key;
- (NSString*)getPreference:(NSString*)key;
- (NSString*)getPreference:(NSString*)key defaultValue:(NSString*)defaultValue;
- (BOOL)removePreference:(NSString*)key;
- (BOOL)removeAllPreference;

@end
