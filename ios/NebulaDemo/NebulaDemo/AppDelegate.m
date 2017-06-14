//
//  AppDelegate.m
//  NebulaDemo
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark NebulaDelegate Methods
- (void)registerServices
{
    [super registerServices];
    [Nebula registerService:[NBPluginService new] forKey:SERVICE_KEY_PREFERENCE];
}

- (void)loadPlugins
{
    NBPluginService* pluginService = [Nebula serviceWithKey:SERVICE_KEY_PLUGIN];
    [pluginService addPluginClass:@"NBPreferencePlugin" actionGroup:PLUGIN_GROUP_PREFERENCE];
    [pluginService addPluginClass:@"NBDeviceInfoPlugin" actionGroup:PLUGIN_GROUP_DEVICEINFO];
    [pluginService addPluginClass:@"NBFileSystemPlugin" actionGroup:PLUGIN_GROUP_FILESYSTEM];
    [pluginService addPluginClass:@"NBNativeEventPlugin" actionGroup:PLUGIN_GROUP_NATIVEEVENT];
    [pluginService addPluginClass:@"NBScreenShotPlugin" actionGroup:PLUGIN_GROUP_SCREENSHOT];
    [pluginService addPluginClass:@"NBGeolocationPlugin" actionGroup:PLUGIN_GROUP_GEOLOCATION];
    [pluginService addPluginClass:@"NBStatusBarPlugin" actionGroup:PLUGIN_GROUP_STATUSBAR];
}

@end
