//
//  NCCommon.m
//  NodeChat
//
//  Created by wangjian on 14-11-17.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//





#import "JCommon.h"

@implementation JCommon

#if TARGET_OS_IPHONE
+ (CGFloat)iosVersion
{
    static float iosVersion = 0.0f;
    if (iosVersion == 0.0f) {
        iosVersion = [[UIDevice currentDevice] systemVersion].floatValue;
    }
  
    return iosVersion;
}
#endif


+(CGFloat)getAppVersion
{
    static CGFloat version = 0;
    if (version == 0) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *versionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        version = [versionStr floatValue];
    }
    
    return version;
}



@end
