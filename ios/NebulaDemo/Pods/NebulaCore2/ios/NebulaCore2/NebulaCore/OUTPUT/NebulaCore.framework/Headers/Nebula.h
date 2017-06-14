//
//  Nebula.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 22..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nebula : NSObject

+ (void)registerService:(id)serviceObj forKey:(NSString*)key;
+ (id)serviceWithKey:(NSString*)key;

@end
