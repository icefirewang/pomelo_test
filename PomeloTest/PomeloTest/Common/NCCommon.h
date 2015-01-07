//
//  NCCommon.h
//  NodeChat
//
//  Created by wangjian on 14-11-19.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotify_ChatOffline             @"Notify_ChatOffline"
#define kNotify_GateConnectSuc          @"Notify_GateConnected"
#define kNotify_ConnectorConnectSuc     @"Notify_ConnectorConnected"

#define kMessageType_Chat         (1)
#define kMessageType_Image        (2)

#pragma mark 关键值
#define kRelationNothing            (0)
#define kRelationNormal             (1)
#define kRelationFriend             (2)


@interface NCCommon : NSObject

@end
