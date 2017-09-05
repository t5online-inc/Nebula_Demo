//
//  BioAuthenticationPlugin.h
//  BioAuthenticationModule
//
//  Created by Hyunjun Kwak on 2017. 6. 20..
//  Copyright © 2017년 Hyunjun Kwak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NebulaCore/NBPlugin.h>

#define PLUGIN_GROUP_BIO_AUTHENTICATION @"bioauthentication"

@interface BioAuthenticationPlugin : NBPlugin

- (void)isSupported;

- (void)authenticate:(NSString*)message;

@end
