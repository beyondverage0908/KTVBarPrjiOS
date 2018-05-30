//
//  KTVLoginService.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/20.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求成功block
typedef void(^ResponseSuccess)(NSDictionary *result);

@interface KTVLoginService : NSObject

/// 获取用户信息
+ (void)getUserInfo:(NSString *)userId result:(ResponseSuccess)responseResult;

/// 获取验证码
+ (void)getIdentifyingCodeParams:(NSDictionary *)params result:(ResponseSuccess)result;

/// 校验验证是否正确
+ (void)postCheckIndentifyCodeParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 普通登陆
+ (void)getCommonLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 手机快捷登陆
+ (void)postPhoneLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 注册
+ (void)postRegisterParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户注册详情
+ (void)postRegisterDetaliParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 微信登陆
+ (void)postWechatLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// QQ登陆
+ (void)postQQLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 更改密码
+ (void)postChangePassword:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 更新第三方登录
+ (void)postUpdateThird:(NSDictionary *)params result:(ResponseSuccess)responseResult;

@end
