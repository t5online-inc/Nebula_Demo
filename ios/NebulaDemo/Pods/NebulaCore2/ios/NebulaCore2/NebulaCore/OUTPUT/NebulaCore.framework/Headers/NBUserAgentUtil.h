//
//  NBUserAgentUtil.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBUserAgentUtil : NSObject

+ (NSString*)originalUserAgent;
+ (void)acquireLock:(void (^)(NSInteger lockToken))block;
+ (void)releaseLock:(NSInteger*)lockToken;
+ (void)setUserAgent:(NSString*)value lockToken:(NSInteger)lockToken;

@end
