//
//  KTVUrl.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/20.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVUrl : NSObject

/// 获取项目的域名
+ (NSString *)getDomainUrl;
/// 获取验证码
+ (NSString *)getIdentifyingCodeUrl;
/// 一般登录（手机号+密码）
+ (NSString *)getCommonLoginUrl;
/// QQ登录
+ (NSString *)getQQLoginUrl;
/// 微信登录
+ (NSString *)getWeChatLoginUrl;
/// 用户注册

@end
