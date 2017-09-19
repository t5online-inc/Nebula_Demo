//
//  NBPlugin.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBBridgeContainer.h"
#import "NBWebViewController.h"

#define ERROR_CODE_NO_PLUGIN            @"E0000"
#define ERROR_CODE_NO_METHOD            @"E0001"
#define ERROR_CODE_NOT_SUPPORT_SYNC     @"E0002"
#define ERROR_CODE_NOT_SUPPORT_ASYNC    @"E0003"

#define ERROR_CODE_COMMON               @"E1000"

@interface NBPlugin : NSObject

@property (nonatomic, strong) NSString* action;
@property (nonatomic, strong) NBBridgeContainer* bridgeContainer;

- (BOOL)isSupportSync;
- (BOOL)isSupportAsync;

- (void)resolve:(id)result;
- (void)resolve;
- (void)reject:(NSString*)code message:(NSString*)message data:(id)data;
- (void)reject;

@end
