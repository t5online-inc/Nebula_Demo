//
//  NSObject+Invocation.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 29..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Invocation)

/**
 * argNames : should be reoder with correct selector
 */
- (SEL)findSelector:(NSString*)methodName argNames:(NSMutableArray**)argNames;

@end
