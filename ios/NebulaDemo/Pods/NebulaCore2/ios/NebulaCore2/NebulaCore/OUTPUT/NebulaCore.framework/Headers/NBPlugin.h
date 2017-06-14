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

@interface NBPlugin : NSObject

@property (nonatomic, strong) NSString* action;
@property (nonatomic, strong) NBBridgeContainer* bridgeContainer;

- (void)resolve:(id)result;
- (void)resolve;
- (void)reject:(NSString*)code message:(NSString*)message data:(id)data;
- (void)reject;

@end
