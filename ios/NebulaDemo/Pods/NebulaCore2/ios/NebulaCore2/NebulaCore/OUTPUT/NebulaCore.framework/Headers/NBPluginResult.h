//
//  NBPluginResult.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+Json.h"
#import "NSString+Coding.h"

#define CODE    @"code"
#define MESSAGE @"message"
//#define DATA    @"data"
#define DETAIL  @"detail"

@interface NBPluginResult : NSObject

- (NBPluginResult*)initWithKey:(NSString*)key;
- (NSString*)setResolve:(id)result;
- (NSString*)setReject:(id)result;
- (NSString*)setException:(NSString*)reason;

@end
