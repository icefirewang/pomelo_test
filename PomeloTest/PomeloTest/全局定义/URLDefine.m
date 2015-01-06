//
//  URLDefine.m
//  NodeChat
//
//  Created by wang jian on 14-11-29.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import "URLDefine.h"




@implementation URLDefine

+(NSURL*)getImageURL:(NSString*)key
{
    NSString * link = [NSString stringWithFormat:@"%@%@",kURL_Qiniu_Image,key];
    return [NSURL URLWithString:link];
}
+(NSURL*)getAvatarURL:(NSString*)key
{
    NSString * link = [NSString stringWithFormat:@"%@%@",kURL_Qiniu_Avatar,key];
    return [NSURL URLWithString:link];
}

@end
