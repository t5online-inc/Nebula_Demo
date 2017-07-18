//
//  NBBridgeContainer.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 6. 1..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBBridgeContainer : NSObject
@property (nonatomic, weak) NSURLRequest* request;
@property (nonatomic, weak) NSURLProtocol* urlProtocol;
@property (nonatomic, weak) UIViewController* viewController;
@property (nonatomic, assign) BOOL isSync;
@end
