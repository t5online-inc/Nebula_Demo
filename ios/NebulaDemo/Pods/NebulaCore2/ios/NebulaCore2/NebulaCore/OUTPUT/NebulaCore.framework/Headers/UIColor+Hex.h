//
//  UIColor+Hex.h
//  NebulaCore
//
//  Created by SungJu on 2017. 5. 29..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)col;              // takes @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str;    // takes 0x123456

@end
