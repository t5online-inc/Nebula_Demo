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
    NSMutableDictionary* retData = [NSMutableDictionary dictionary];
    BOOL isSync = [self.bridgeContainer isSync];
    
    if (isSync) {
        [retData setObject:@(STATUS_CODE_ERROR) forKey:@"code"];
        [retData setObject:@"unsupported syncronize" forKey:@"message"];
    } else {
        UIViewController* viewController = self.bridgeContainer.viewController;
        
        if([viewController isKindOfClass:[NBWebViewController class]]){
            UIColor* color = [UIColor colorWithHexString:backgroundColor];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [(NBWebViewController*)viewController setStatusBar:[isHidden boolValue] backgroundColor:color isDefault:[isDefault boolValue]];
            });
            
            [retData setObject:@(STATUS_CODE_SUCCESS) forKey:@"code"];
            [retData setObject:@"" forKey:@"message"];
        } else {
            [retData setObject:@(STATUS_CODE_ERROR) forKey:@"code"];
            [retData setObject:@"not found webview" forKey:@"message"];
        }
    }
    
    [self resolve:retData];
}

@end
