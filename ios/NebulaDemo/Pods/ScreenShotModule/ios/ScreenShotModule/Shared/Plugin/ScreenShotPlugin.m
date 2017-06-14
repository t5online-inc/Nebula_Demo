//
//  ScreenShotPlugin.m
//  ScreenShotModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "ScreenShotPlugin.h"

@implementation ScreenShotPlugin

-(void)takePicture
{
    [self saveScreenshotToPhotosAlbum:[[[UIApplication sharedApplication] delegate] window].rootViewController.view];
    [self resolve];
}

- (UIImage*)captureView:(UIView *)view
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)saveScreenshotToPhotosAlbum:(UIView *)view
{
    UIImageWriteToSavedPhotosAlbum([self captureView:view], nil, nil,nil);
}

@end
