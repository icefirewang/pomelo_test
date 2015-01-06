//
//  NCCommon.h
//  NodeChat
//
//  Created by wangjian on 14-11-17.
//  Copyright (c) 2014年 jiayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLDefine.h"

#define J_IS_IOS7   ([JCommon iosVersion] >= 7.0)
#define DLocalString(a)     NSLocalizedString(a,nil)
#define LOG_RECT(rect)    NSLog(@"Rect %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)

#pragma mark perform 防警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



#if TARGET_OS_IPHONE

#define FONT(x)         [UIFont systemFontOfSize:x]
#define FONT_BOLD(x)    [UIFont boldSystemFontOfSize:x]

#elif TARGET_OS_MAC

#define FONT(x)         [NSFont systemFontOfSize:x]
#define FONT_BOLD(x)    [NSFont boldSystemFontOfSize:x]

#endif


#define kNotify_MessageImageUploadPersent   @"MessageImageUploadPersent"


@interface JCommon : NSObject



#if TARGET_OS_IPHONE
+(CGFloat)iosVersion;
#endif
+(CGFloat)getAppVersion;


@end
