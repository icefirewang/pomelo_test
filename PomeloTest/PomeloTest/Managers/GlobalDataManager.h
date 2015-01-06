//
//  GlobalDataManager.h
//  NodeChat
//
//  Created by wangjian on 14-11-19.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CurUserId   [GlobalDataManager sharedDataManager].userInfo.userid


@interface GlobalDataManager : NSObject

@property (nonatomic,strong) NCUserInfo *userInfo;
@property (nonatomic,strong) NSString *token;

+(GlobalDataManager*)sharedDataManager;

@end
