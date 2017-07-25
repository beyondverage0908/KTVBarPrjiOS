//
//  KTVShareSDKManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/25.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVShareSDKManager.h"

@implementation KTVShareSDKManager

+ (void)shareSDKInitial {
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeSinaWeibo:
                                         //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                         [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                                   appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                                 redirectUri:@"http://www.sharesdk.cn"
                                                                    authType:SSDKAuthTypeBoth];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                               appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [appInfo SSDKSetupQQByAppId:@"100371282"
                                                              appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                                            authType:SSDKAuthTypeBoth];
                                         break;
                                     default:
                                         break;
                                 }
                             }];
}

@end
