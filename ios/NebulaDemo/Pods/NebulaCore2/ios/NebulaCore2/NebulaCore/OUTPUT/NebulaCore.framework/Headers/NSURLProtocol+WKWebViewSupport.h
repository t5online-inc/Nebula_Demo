//
//  NSURLProtocol+WKWebViewSupport.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 7. 31..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLProtocol (WKWebViewSupport)

+ (void)wk_registerScheme:(NSString *)scheme;
+ (void)wk_unregisterScheme:(NSString *)scheme;

@end
