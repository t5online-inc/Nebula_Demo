//
//  ScreenShotPlugin.m
//  ScreenShotModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "ScreenShotPlugin.h"
#import <QuartzCore/QuartzCore.h>

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
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    
    if (error) {
        [retData setObject:@(STATUS_CODE_ERROR) forKey:@"code"];
        [retData setObject:error forKey:@"message"];
    } else {
        [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
        [retData setObject:@"" forKey:@"message"];
    }
    
    [self resolve:retData];
}

@end
