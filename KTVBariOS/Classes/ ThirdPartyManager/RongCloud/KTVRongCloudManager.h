//
//  KTVRongCloudManager.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

@interface KTVRongCloudManager : NSObject

/// 初始化融云SDK
+ (void)rongInit;

/// 链接融云服务器-token：通过向自己服务器获取
+ (void)connectWithToken:(NSString *)token;

@end
