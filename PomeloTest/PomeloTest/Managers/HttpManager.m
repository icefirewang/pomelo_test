//
//  HttpManager.m
//  NodeChat
//
//  Created by wangjian on 14-10-9.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import "HttpManager.h"
#import "MyMD5.h"
#import "URLDefine.h"
#define kURL            @"URL"
#define kPar            @"PAR"

#define kStatus         @"status"
#define kToken          @"token"

@implementation HttpManager



#pragma 总请求接口
+ (AFHTTPRequestOperation *)postUrl:(NSString *)url withParams:(NSDictionary *)params  withSuccess:(Success)successBlock withFailed:(Failed)failedBlock{
    
    NSLog(@"request with URL :%@",url);
    NSLog(@"paras :%@",params);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    AFHTTPRequestOperation *httpRequestOperation=[manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error.code);
        
        NSLog(@"failed:%@ code %ld",operation.responseString,error.code);
        NSLog(@"faild description %@",error.debugDescription);
        
    }];
    return httpRequestOperation;
}

#pragma 总请求接口
+ (AFHTTPRequestOperation *)getUrl:(NSString *)url withParams:(NSDictionary *)params  withSuccess:(Success)successBlock withFailed:(Failed)failedBlock{
    
    NSLog(@"request with URL :%@",url);
    NSLog(@"paras :%@",params);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript", nil];
    AFHTTPRequestOperation *httpRequestOperation=[manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error.code);
        
        NSLog(@"failed:%@ code %ld",operation.responseString,error.code);
        NSLog(@"faild description %@",error.debugDescription);
        
    }];
    return httpRequestOperation;
}

+ (AFHTTPRequestOperation *)postWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock
{
    
    NSString *URL = [params objectForKey:kURL];
    if (URL == nil) {
        NSAssert(FALSE, @"URL为空");
    }else{
        NSLog(@"URL:%@",URL);
    }
    NSDictionary *par = [params objectForKey:kPar];
    NSMutableDictionary *parWithSession;
    if (par != nil) {
        parWithSession = [NSMutableDictionary dictionaryWithDictionary:par];
    }else{
        parWithSession = [NSMutableDictionary dictionary];
    }
    
    NSString *token = [GlobalDataManager sharedDataManager].token;
    
    if (token == nil) {
        token = @"";
    }
    [parWithSession setObject:token forKey:kToken];
    [parWithSession setObject:@"1" forKey:@"device"];
    [parWithSession setObject:@"version" forKey:@([JCommon getAppVersion])];
    
    return [HttpManager postUrl:URL withParams:parWithSession withSuccess:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSInteger ret = 0;
        if ([dict objectForKey:kStatus]) {
            ret =  [[dict objectForKey:kStatus] integerValue];
        }
        successBlock(dict,ret);
        
        if (ret != 0) {
         //   [HttpManager handleErrorStatus:ret];
        }
        
    } withFailed:^(NSInteger errorCode) {
        failBlock(errorCode);
        
    }];
}

+ (AFHTTPRequestOperation *)postWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock  common:(Common)comm
{
    
    NSString *URL = [params objectForKey:kURL];
    if (URL == nil) {
        NSAssert(FALSE, @"URL为空");
    }else{
        NSLog(@"URL:%@",URL);
    }
    NSDictionary *par = [params objectForKey:kPar];
    NSMutableDictionary *parWithSession;
    if (par != nil) {
        parWithSession = [NSMutableDictionary dictionaryWithDictionary:par];
    }else{
        parWithSession = [NSMutableDictionary dictionary];
    }
    
    NSString *token = [GlobalDataManager sharedDataManager].token;
    
    //    static NSInteger debug = NO;
    //    if (debug == YES) {
    //        session = @"9140dakjKg2NpGWo1IOwsaicR4GBh5GyV7Qajbvlq1DGithGGQ";
    //    }
    
    if (token == nil) {
        token = @"";
    }
    [parWithSession setObject:token forKey:kToken];
    [parWithSession setObject:@"1" forKey:@"dt"];
    [parWithSession setObject:@([JCommon getAppVersion]) forKey:@"ver"];
    
    return [HttpManager postUrl:URL withParams:parWithSession withSuccess:^(NSDictionary *dict) {
        NSLog(@"返回：%@",dict);
        NSInteger ret = 0;
        if ([dict objectForKey:kStatus]) {
            ret =  [[dict objectForKey:kStatus] integerValue];
        }
        if (comm != nil) comm();
        
        if (successBlock) {
            successBlock(dict,ret);
        }
        
        
        if (ret != 0) {
        //    [HttpManager handleErrorStatus:ret];
        }
        
    } withFailed:^(NSInteger errorCode) {
        
        NSLog(@"local error code %ld",errorCode);
        
        NSString *str = [NSString stringWithFormat:@"网络错误"];
        
        if (comm != nil) comm();
        
        if (failBlock) {
            failBlock(errorCode);
        }
    }];
}

+ (AFHTTPRequestOperation *)getWithTotalParams:(NSDictionary *)params withSuccess:(HttpSuccess)successBlock fail:(Failed)failBlock  common:(Common)comm
{
    
    NSString *URL = [params objectForKey:kURL];
    if (URL == nil) {
        NSAssert(FALSE, @"URL为空");
    }else{
        NSLog(@"URL:%@",URL);
    }
    NSDictionary *par = [params objectForKey:kPar];
    NSMutableDictionary *parWithSession;
    if (par != nil) {
        parWithSession = [NSMutableDictionary dictionaryWithDictionary:par];
    }else{
        parWithSession = [NSMutableDictionary dictionary];
    }
    
    
    return [HttpManager getUrl:URL withParams:parWithSession withSuccess:^(NSDictionary *dict) {
        NSLog(@"返回：%@",dict);
        if (comm != nil) comm();
        
        if (successBlock) {
            successBlock(dict, 0);
        }
        
    } withFailed:^(NSInteger errorCode) {
        
        NSLog(@"local error code %ld",errorCode);
        
        NSString *str = [NSString stringWithFormat:@"网络错误"];
     //   [[HUDManager sharedHUDManager] dismissWithError:str];
        
        if (comm != nil) comm();
        
        if (failBlock) {
            failBlock(errorCode);
        }
    }];
}



+(NSString*)httpServer
{

    return @"http://api.cloudnear.net";
}

+(NSString*)chatServer
{
  //  return @"10.0.0.184";
 //  return @"192.168.0.100";
    return @"localhost";
}

+(NSInteger)chatPort
{
    return 3011;
}

+(NSInteger)gatePort
{
    return 3014;
}

+(NSString*)avatarImageAdr
{
    return @"nearbuy-avatars.qiniudn.com";
}

+(NSString*)imageImageAdr
{
    return @"nearbuy-images.qiniudn.com";
}

+(NSString*)chatImageAdr
{
    return @"nearbuy-chat.qiniudn.com";
}

#pragma mark-
#pragma mark-

#pragma mark - 0. 图片
#pragma mark - 0.1 头像图片
+(NSURL*)getAvatar:(NSString*)key pix:(NSInteger)pix
{
    NSString *str;
    if (pix == 0) {
        str = [NSString stringWithFormat:@"%@/%@",[HttpManager avatarImageAdr],key];
    }else{
        str = [NSString stringWithFormat:@"%@/%@?imageView2/2/w/%ld/h/%ld/q/85",[HttpManager avatarImageAdr],key,pix,pix];
    }
    return [NSURL URLWithString:str];
}
#pragma mark - 0.2 图片
+(NSURL*)getImage:(NSString*)key pix:(NSInteger)pix
{
    NSString *str;
    if (pix == 0) {
        str = [NSString stringWithFormat:@"%@/%@",[HttpManager imageImageAdr],key];
    }else{
        str = [NSString stringWithFormat:@"%@/%@?imageView2/2/w/%ld/h/%ld/q/85",[HttpManager imageImageAdr],key,pix,pix];
    }
    return [NSURL URLWithString:str];
}


#pragma mark - 0.3 聊天图片
+(NSURL*)getChatImage:(NSString*)key pix:(NSInteger)pix
{
    NSString *str;
    if (pix == 0) {
        str = [NSString stringWithFormat:@"%@/%@",[HttpManager imageImageAdr],key];
    }else{
        str = [NSString stringWithFormat:@"%@/%@?imageView2/2/w/%ld/h/%ld/q/85",[HttpManager imageImageAdr],key,pix,pix];
    }
    return [NSURL URLWithString:str];

}

#pragma mark - 1. 注册,登录
#pragma mark 1.1 注册
+(NSDictionary*)par_RegistWithPhone:(NSString*)phone nick:(NSString*)nick password:(NSString*)pw
{
    NSString *md5Pw = [MyMD5 md5:pw];
    NSDictionary *par = @{
                          @"nick" : nick,
                          @"email" : phone,
                          @"password" : md5Pw
                          };
    
    return @{
             kPar : par,
             kURL : kURL_Regist
             };
}
#pragma mark 1.2 账号登陆
+(NSDictionary*)par_LoginWithPhone:(NSString*)phone  password:(NSString*)pw
{
    NSString *md5Pw = [MyMD5 md5:pw];
    NSDictionary *par = @{
                          @"email" : phone,
                          @"password":md5Pw
                          };
    return @{
             kPar : par,
             kURL : kURL_Login
             };
}


#pragma mark 1.3 token登陆
+(NSDictionary*)par_LoginWithToken:(NSString*)token
{
    NSDictionary *par = @{
                            @"token":token
                            };
    return @{
             kPar : par,
             kURL : kURL_Token_login
             };
}

#pragma mark - 2. 七牛
#pragma mark - 2.1 获取头像key
+(NSDictionary*)par_getAvatarKey
{
    NSDictionary *par = @{
                          @"bucket":@"nearbuy-avatars"
                          };
    return @{
             kPar : par,
             kURL : kURL_Get_Qiniu_Token
             };
}


#pragma mark - 2.2 获取图片key
+(NSDictionary*)par_getImageKey
{
    NSDictionary *par = @{
                          @"bucket":@"nearbuy-images"
                          };
    return @{
             kPar : par,
             kURL : kURL_Get_Qiniu_Token
             };

}

+(NSDictionary*)par_getChatImageKey
{
    NSDictionary *par = @{
                          @"bucket":@"nearbuy-chat"
                          };
    return @{
             kPar : par,
             kURL : kURL_Get_Qiniu_Token
             };
    

}




@end
