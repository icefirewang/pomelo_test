//
//  GlobalDataManager.m
//  NodeChat
//
//  Created by wangjian on 14-11-19.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import "GlobalDataManager.h"

@implementation GlobalDataManager


-(NCUserInfo*)userInfo
{
    if (_userInfo == nil) {
        _userInfo = [[NCUserInfo alloc] init];
    }
    return _userInfo;
}

+(GlobalDataManager*)sharedDataManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
        
    });
    return _sharedObject;
}
@end
