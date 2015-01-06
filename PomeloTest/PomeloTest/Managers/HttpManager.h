//
//  HttpManager.h
//  NodeChat
//
//  Created by wangjian on 14-10-9.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSDictionary *dict);
typedef void (^HttpSuccess)(NSDictionary *data,NSInteger status);
typedef void (^Failed)(NSInteger errorCode);
typedef void (^Common)(void);



@interface HttpManager : NSObject


+(NSString*)httpServer;
+(NSString*)chatServer;
+(NSInteger)chatPort;


+(AFHTTPRequestOperation*)postWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock;
+(AFHTTPRequestOperation*)postWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock  common:(Common)comm;
+ (AFHTTPRequestOperation *)getWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock  common:(Common)comm;



#pragma mark - 0. 图片
#pragma mark - 0.1 头像图片
+(NSURL*)getAvatar:(NSString*)key pix:(NSInteger)pix;
#pragma mark - 0.2 图片
+(NSURL*)getImage:(NSString*)key pix:(NSInteger)pix;
#pragma mark - 0.3 聊天图片
+(NSURL*)getChatImage:(NSString*)key pix:(NSInteger)pix;


#pragma mark - 1. 注册,登录
#pragma mark 1.1 注册
+(NSDictionary*)par_RegistWithPhone:(NSString*)phone nick:(NSString*)nick password:(NSString*)pw;
#pragma mark 1.2 账号登陆
+(NSDictionary*)par_LoginWithPhone:(NSString*)phone  password:(NSString*)pw;
#pragma mark 1.3 token登陆
+(NSDictionary*)par_LoginWithToken:(NSString*)token;

#pragma mark - 2. 七牛
#pragma mark - 2.1 获取头像key
+(NSDictionary*)par_getAvatarKey;
#pragma mark - 2.2 获取图片key
+(NSDictionary*)par_getImageKey;




@end
