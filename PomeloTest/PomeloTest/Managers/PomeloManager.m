//
//  SocketManager.m
//  NodeChat
//
//  Created by wangjian on 14-10-9.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

/* out route */
#define kRouteGetPort               @"gate.gateHandler.queryEntry"

#define kRouteRegist                @"connector.regist.regist"
#define kRouteLogin                 @"connector.login.login"
#define kRouteGetOfflineMessage     @"connector.login.getOfflineMessage"
#define kRouteSend                  @"connector.chat.send"
#define kRouteGetUserInfo           @"connector.chat.getUserInfo"
#define kRouteChangeAvatar          @"connector.changeAvatar.changeAvatar"
#define kRouteRelation              @"connector.relation.setRelaiont"
#define kRouteBlacklist             @"connector.relation.setBlack"

// test
#define kRouteIsUserExist           @"connector.login.isUserExist"

#define kRoute

/* test route */

/* in route */
#define kRouteChatMessage       @"ChatMessage"
#define kRouteOfflineMessage    @"OfflineMessage"
#define kRouteSysMessage        @"SysMessage"
#define kRouteRelationMessage   @"RelationMessage"




typedef enum connectStatus{
    E_NONE,
    E_GATE_TRY,
    E_GATE_SUC,
    E_GATE_CUT,
    E_CONNECTOR_TRY,
    E_CONNECTOR_SUC
} ConnectStatus;

#import "NCCommon.h"
#import "PomeloManager.h"
#import "Pomelo.h"
#import "HttpManager.h"
@interface PomeloManager ()<PomeloDelegate>

@property (nonatomic,strong) Pomelo *pomelo;
@property (nonatomic) ConnectStatus connectStatus;

@property (nonatomic,strong) NSString *connectorIP;
@property (nonatomic) NSInteger connectorPort;

@end

@implementation PomeloManager


#pragma mark - test
-(void)test
{
    [self isUserExist:@"2"];
}

#pragma mark -  object


-(Pomelo*)pomelo
{
    if (_pomelo == nil) {
        _pomelo = [[Pomelo alloc] initWithDelegate:self];
    }
    return _pomelo;
}

#pragma mark - action
-(void)isUserExist:(NSString*)uid
{
    NSDictionary *par = @{
                          @"uid":uid
                          };
    [self.pomelo requestWithRoute:kRouteIsUserExist andParams:par andCallback:^(id callback) {
        
    }];
}
-(void)connectToGate
{
    self.connectStatus = E_GATE_TRY;
    [self.pomelo connectToHost:[HttpManager chatServer] onPort:[HttpManager gatePort]];
}
#pragma mark -  获取connector 信息
-(void)getConnectorInfo:(NSString*)userid
{
    NSDictionary *dic = @{
                          @"userid":userid
                          };
    [self.pomelo requestWithRoute:kRouteGetPort andParams:dic andCallback:^(NSDictionary* callback) {
        NSLog(@"getConnector info %@",callback);
        NSInteger status = [[callback objectForKey:@"status"] integerValue];
        if (status == 0) {
            self.connectorIP = [callback objectForKey:@"host"];
            self.connectorPort = [[callback objectForKey:@"port"] integerValue];
            self.connectStatus = E_GATE_CUT;
            [self disConnect];
           
        }
    }];
}

-(void)connectToConnectorWithAdr:(NSString*)address port:(NSInteger)port
{
    [self.pomelo connectToHost:address onPort:port];
}

-(void)connect
{
    [self.pomelo connectToHost:[HttpManager chatServer] onPort:[HttpManager chatPort] withCallback:^(id callback) {
        NSLog(@"call back %@",callback);
    }];
}


-(void)connectOnPort:(NSString*)port
{
    NSInteger iPort = [port integerValue];
    [self.pomelo connectToHost:[HttpManager chatServer] onPort:iPort withCallback:^(id callback) {
        NSLog(@"call back %@",callback);
    }];
}

-(void)disConnect
{
    [self.pomelo disconnect];
}

#pragma mark - 登陆
-(void)loginWithUser:(NSString*)user password:(NSString*)pw reqFinish:(ReqFinished)finish
{
    NSDictionary *par = @{
                          @"user":user,
                          @"password":pw
                          };
    [self.pomelo requestWithRoute:kRouteLogin andParams:par andCallback:^(NSDictionary* callback) {
        NSLog(@"login >>%@",callback);
        NSInteger status = -1;
        if ([callback objectForKey:@"status"]) {
            status = [[callback objectForKey:@"status"] integerValue];
        }
        finish(status,callback);
        
    }];
}

#pragma mark - 获取离线数据
-(void)getOfflineMessage:(ReqFinished)finished
{
    [self.pomelo requestWithRoute:kRouteGetOfflineMessage andParams:nil andCallback:^(NSDictionary* callback) {
        NSLog(@"get off line message :>>");
        NSLog(@"%@",callback);
        NSInteger status = [[callback objectForKey:@"status"] integerValue];
        finished(status,callback);
    }];
}


#pragma mark -  初始化接收Route
-(void)initEvent:(Pomelo*)pomelo
{
    [self.pomelo onRoute:kRouteChatMessage withCallback:^(NSDictionary* data) {
    
    }];
    
    [self.pomelo onRoute:kRouteSysMessage withCallback:^(NSDictionary* data) {

    }];
    
    [self.pomelo onRoute:kRouteOfflineMessage withCallback:^(NSDictionary* callback) {
        
    }];
}


-(void)handleChatMessagesArray:(NSArray*)array
{

    for (NSDictionary *msg in array) {
        [self handleChatMessage:msg];
    }
    NSLog(@"receive chat message count :%ld",array.count);
    
}

-(void)handleOfflineMessageArray:(NSArray*)array
{
    for (NSString *msg in array) {
        NSDictionary *msgDict = [msg toJsonObject];
        [self handleChatMessage:msgDict];
    }
    NSLog(@"receive offline message count :%ld",array.count);

}


-(void)handleChatMessage:(NSDictionary*)msg
{
    
}



#pragma mark -  发送数据
-(void)sendMessage:(NSDictionary*)dict toUId:(long long)uid finished:(ReqFinished)finished
{
    NSDictionary *par = @{
                          @"to": [NSNumber numberWithLongLong:uid],
                          @"content" :dict
                          };
    
    [self.pomelo requestWithRoute:kRouteSend andParams:par andCallback:^(NSDictionary* back) {
        NSLog(@"send message call back %@",back);
        NSInteger status = -1;
        if ([back objectForKey:@"status"]) {
            status  = [[back objectForKey:@"status"] integerValue];
        }
        finished(status,back);
        
    }];
}

#pragma mark 获取用户信息
-(void)getUserInfo:(long long)user finished:(ReqFinished)finished
{
    [self.pomelo requestWithRoute:kRouteGetUserInfo andParams:@{@"uid":[NSNumber numberWithLongLong:user]} andCallback:^(NSDictionary* callback) {
        NSInteger status = -1;
        NSDictionary *content = nil;
        if ([callback objectForKey:@"status"]) {
            status  = [[callback objectForKey:@"status"] integerValue];
            content = [callback objectForKey:@"content"];
        }
        finished(status,content);
    }];
}
#pragma mark 修改头像
-(void)changeAvatar:(NSString*)avatarKey
{
    NSDictionary *par = @{
                          @"key":avatarKey
                          };
    [self.pomelo requestWithRoute:kRouteChangeAvatar andParams:par andCallback:^(NSDictionary* callback) {
        
    }];
}
#pragma mark 设置关系
-(void)setRelation:(long long)userid type:(NSInteger)type
{
    NSDictionary *par = @{
                          @"to_uid" : [NSNumber numberWithLongLong:userid],
                          @"type"   : [NSNumber numberWithInteger:type]
                          };
    
    [self.pomelo requestWithRoute:kRouteRelation andParams:par andCallback:^(NSDictionary* callback) {
        NSLog(@"setRelation :> %@",callback);
    }];
}

#pragma mark - Pomelo Delegate
-(void)Pomelo:(Pomelo *)pomelo didReceiveMessage:(NSDictionary *)message
{
    NSString *route = nil;
    if ([message objectForKey:@"route"]) {
        route = [message objectForKey:@"route"];
    }
    id body = [message objectForKey:@"body"];
    if (body == nil || route == nil ) {
        return;
    }
    
    if ([route isEqualToString:kRouteChatMessage]) {
        [self handleChatMessagesArray:body];
    }else if ([route isEqualToString:kRouteOfflineMessage]) {
        [self handleOfflineMessageArray:body];
    }else if ([route isEqualToString:kRouteRelationMessage]){
        
    }
    
}

-(void)PomeloDidConnect:(Pomelo *)pomelo
{
    NSLog(@"connected");
    if (self.connectStatus == E_GATE_TRY) {
        self.connectStatus = E_GATE_SUC;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_GateConnectSuc object:nil];
    }else if(self.connectStatus == E_CONNECTOR_TRY){
        self.connectStatus = E_CONNECTOR_SUC;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_ConnectorConnectSuc object:nil];
    }
}

-(void)PomeloDidDisconnect:(Pomelo *)pomelo withError:(NSError *)error
{
    NSLog(@"disconnect %@",error.debugDescription);
    if (self.connectStatus == E_GATE_CUT) {
        self.connectStatus = E_CONNECTOR_TRY;
        [self connectToConnectorWithAdr:self.connectorIP port:self.connectorPort];
    }

}



+(PomeloManager*)sharedPomeloManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
@end
