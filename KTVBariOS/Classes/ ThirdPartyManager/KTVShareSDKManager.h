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
// 导入头文件
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
// 用于分享
#import <ShareSDKUI/ShareSDK+SSUI.h>

typedef enum : NSUInteger {
    KTVShareSDKQQLoginType,
    KTVShareSDKWeChatLoginType,
    KTVShareSDKSinaType
} KTVShareSDKType;

@interface KTVShareSDKManager : NSObject

+ (void)shareSDKInitial;

+ (void)thirdpartyLogin:(KTVShareSDKType)loginType;
    
/**
 *  设置分享参数
 *
 *  @param text     文本
 *  @param images   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url      网页路径/应用路径
 *  @param title    标题
 */
+ (void)thirdpartyShareTitle:(NSString *)title text:(NSString *)text images:(NSArray *)images targetUrl:(NSURL *)url;

@end
