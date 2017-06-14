//
//  StatusBarPlugin.m
//  StatusBarModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "StatusBarPlugin.h"
#import "UIColor+Hex.h"

@implementation StatusBarPlugin

- (void)setStatusBar:(NSNumber*)isHidden backgroundColor:(NSString*)backgroundColor isDefault:(NSNumber*)isDefault
{
    UIViewController * viewCon = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if([viewCon isKindOfClass:[NBWebViewController class]]){
        UIColor * color = [UIColor colorWithHexString:backgroundColor];
        dispatch_async(dispatch_get_main_queue(), ^{
            [((NBWebViewController*)viewCon) setStatusBar:[isHidden boolValue] backgroundColor:color isDefault:[isDefault boolValue]];
            
        });
    }
    [self resolve];
}

@end
