//
//  NBAppDelegate.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 22..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NebulaDelegate <NSObject>
- (void)registerServices;
- (void)loadPlugins;
@end

@interface NBAppDelegate : UIResponder <UIApplicationDelegate, NebulaDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

