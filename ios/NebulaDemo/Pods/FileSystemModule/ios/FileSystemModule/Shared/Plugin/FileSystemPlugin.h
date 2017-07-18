//
//  FileSystemPlugin.h
//  FileSystemModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NebulaCore/NBPlugin.h>

#define PLUGIN_GROUP_FILESYSTEM     @"filesystem"

@interface FileSystemPlugin : NBPlugin

- (void)selectFile:(NSNumber*)quality width:(NSNumber*)Width height:(NSNumber*)height;

@end
