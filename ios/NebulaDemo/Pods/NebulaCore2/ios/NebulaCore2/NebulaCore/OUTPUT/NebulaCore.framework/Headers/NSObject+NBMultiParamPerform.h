//
//  NSObject+NBMultiParamPerform.h
//  NebulaCore
//
//  Created by JoAmS on 2017. 5. 22..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NBMultiParamPerform)

- (void)performSelector:(SEL)aSelector withParams:(void *)param, ...;

- (void)performSelector:(SEL)aSelector withParamArray:(NSArray*)paramArray;

@end
