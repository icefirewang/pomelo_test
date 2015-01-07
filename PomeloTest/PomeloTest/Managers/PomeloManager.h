//
//  SocketManager.h
//  NodeChat
//
//  Created by wangjian on 14-10-9.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#define kPomeloErr_nothing        (0)


#define kRelation_friend            (1)
#define kRelation_normal            (2)


#import <Foundation/Foundation.h>


typedef void (^ReqFinished)(NSInteger status, NSDictionary* content);

@interface PomeloManager : NSObject

-(void)connectOnPort:(NSString*)port;
#pragma mark  connect
-(void)connect;
#pragma mark  disconnect;
-(void)disConnect;
#pragma mark 登陆
-(void)loginWithUser:(NSString*)user password:(NSString*)pw reqFinish:(ReqFinished)finish;
#pragma mark 发送数据
-(void)sendMessage:(NSDictionary*)dict toUId:(long long)uid finished:(ReqFinished)finished;
#pragma mark 获取用户信息
-(void)getUserInfo:(long long)user finished:(ReqFinished)finished;
#pragma mark 修改头像
-(void)changeAvatar:(NSString*)avatarKey;
#pragma mark 获取离线消息
-(void)getOfflineMessage:(ReqFinished)finished;
#pragma mark gate
-(void)connectToGate;
-(void)getConnectorInfo:(NSString*)userid;

#pragma mark-
+(PomeloManager*)sharedPomeloManager;

@end
