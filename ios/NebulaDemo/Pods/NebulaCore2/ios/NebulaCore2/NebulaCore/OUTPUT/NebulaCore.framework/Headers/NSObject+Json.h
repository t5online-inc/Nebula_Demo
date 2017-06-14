//
//  NSObject+Json.h
//  NebulaCore
//
//  Created by SungJu on 2017. 5. 23..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Json)

- (BOOL)isValidJson;
- (NSString *)jsonString;
- (NSDictionary *)jsonDictionary;
- (NSArray *)jsonArray;

@end
