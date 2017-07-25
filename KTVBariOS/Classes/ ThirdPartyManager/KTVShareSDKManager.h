//
//  KTVShareSDKManager.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/25.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

// ShareSDK头文件
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h" //新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

@interface KTVShareSDKManager : NSObject

+ (void)shareSDKInitial;

@end
