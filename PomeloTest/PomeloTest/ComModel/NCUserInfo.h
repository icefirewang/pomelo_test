//
//  NCUserInfo.h
//  NodeChat
//
//  Created by wangjian on 14-11-19.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCUserInfo : NSObject

@property (nonatomic) long long userid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *avatar;

-(void)resetWithDict:(NSDictionary*)dict;

@end
