//
//  URLDefine.h
//  NodeChat
//
//  Created by wang jian on 14-11-29.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FCombineURL(x)    [NSString stringWithFormat:@"%@%@",[self httpServer],x]



#pragma mark -  七牛
#define kURL_Qiniu_Image            @"http://nearbuy-images.qiniudn.com/"
#define kURL_Qiniu_Avatar           @"http://nearbuy-avatars.qiniudn.com/"

#pragma mark -  注册 登陆
#define kURL_Regist                 FCombineURL(@"/user/register.html")
#define kURL_Login                  FCombineURL(@"/user/login.html")
#define kURL_Token_login            FCombineURL(@"/user/tokenlogin.html")
#define kURL_Logout                 FCombineURL(@"/user/logout.html")


#pragma mark -  图片
#define kURL_Get_Qiniu_Token        FCombineURL(@"/qiniu/gettoken.html")





@interface URLDefine : NSObject

+(NSURL*)getImageURL:(NSString*)key;
+(NSURL*)getAvatarURL:(NSString*)key;

@end
