//
//  NBURLProtocol.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBURLProtocol : NSURLProtocol

+(void)registerViewController:(UIViewController*)viewController;
+(void)unregisterViewController:(UIViewController*)viewController;

@end
