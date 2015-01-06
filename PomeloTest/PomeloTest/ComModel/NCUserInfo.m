//
//  NCUserInfo.m
//  NodeChat
//
//  Created by wangjian on 14-11-19.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import "NCUserInfo.h"

@implementation NCUserInfo

-(void)resetWithDict:(NSDictionary*)dict
{
    self.userid = [[dict objectForKey:@"uid"] longLongValue];
    self.nick = [dict objectForKey:@"nick"];
    self.avatar = [dict objectForKey:@"avatar"];
}

@end
