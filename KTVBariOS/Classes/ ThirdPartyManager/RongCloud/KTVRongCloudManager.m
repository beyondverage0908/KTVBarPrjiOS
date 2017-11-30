//
//  KTVRongCloudManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVRongCloudManager.h"

@interface KTVRongCloudManager()<RCIMUserInfoDataSource>

@end

@implementation KTVRongCloudManager

+ (KTVRongCloudManager *)shareManager {
    static KTVRongCloudManager *coordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coordinator = [[KTVRongCloudManager alloc] init];
    });
    return coordinator;
}

- (void)rongInit {
    [[RCIM sharedRCIM] initWithAppKey:[KTVUtil plistForKey:@"RCAPPDEVKEY"]];
    [self connectWithRongCloud];
}

- (void)connectWithRongCloud {
    NSString *rongToken = [KTVCommon userInfo].rongCloudToken;
    if (rongToken) {
        [[RCIM sharedRCIM] connectWithToken:rongToken success:^(NSString *userId) {
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            NSLog(@"rc-success: token: %@ -- userid: %@", rongToken, userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%@", @(status));
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    }
}

#pragma mark - RCIMUserInfoDataSource, RCIMGroupInfoDataSource

// 代理用户信息 - 自定义聊天用户信息显示
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
    NSArray *rcUserList = [KTVUtil objectForKey:@"RCUserList"];
    for (NSDictionary *dic in rcUserList) {
        RCUserInfo *info = [[RCUserInfo alloc] init];
        info.name = dic[@"name"];
        info.userId = dic[@"userId"];
        info.portraitUri = dic[@"portraitUri"];
        
        completion(info);
    }
}

// 代理-应用在前台时候，取消声音提醒
- (BOOL)onRCIMCustomAlertSound:(RCMessage*)message {
    return NO;
}

@end
