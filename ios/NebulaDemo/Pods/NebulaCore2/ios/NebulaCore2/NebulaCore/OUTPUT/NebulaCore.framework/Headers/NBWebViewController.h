//
//  NBWebViewController.h
//  NebulaCore
//
//  Created by Yosam Lee on 2017. 5. 10..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBWebViewController : UIViewController

@property (nonatomic, strong, readonly) UIWebView* webView;

- (void)setStatusBar:(BOOL)isHidden backgroundColor:(UIColor*)backgroundColor isDefault:(BOOL)isDefault;

@end
