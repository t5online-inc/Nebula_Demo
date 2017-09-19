//
//  ScreenShotPlugin.m
//  ScreenShotModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "ScreenShotPlugin.h"
#import <QuartzCore/QuartzCore.h>

#define ERROR_COE_SCREENSHOT_FAIL   @"E10001"

@implementation ScreenShotPlugin

- (void)takePicture
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(window.bounds.size);
    }
    
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark -
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    
    if (error) {
        [self reject:ERROR_COE_SCREENSHOT_FAIL message:[error description] data:nil];
    } else {
        [self resolve];
    }
}

@end
