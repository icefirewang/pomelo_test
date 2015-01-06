//
//  NSString+json.m
//  NodeChat
//
//  Created by wang jian on 14-11-22.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import "NSString+json.h"

@implementation NSString (json)

-(id)toJsonObject
{
    NSError *error = nil;
    id JSON =
    [NSJSONSerialization JSONObjectWithData: [self dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
    return JSON;
}

@end
