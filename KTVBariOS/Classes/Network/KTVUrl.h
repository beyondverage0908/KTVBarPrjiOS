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

/// 核对验证码url
+ (NSString *)getCheckIndentifyCodeUrl;

/// 一般登录（手机号+密码）
+ (NSString *)getCommonLoginUrl;

/// QQ登录
+ (NSString *)getQQLoginUrl;

/// 微信登录
+ (NSString *)getWeChatLoginUrl;

/// 用户注册
+ (NSString *)getRegisterUrl;

/// 用户注册详情
+ (NSString *)getRegisterDetailUrl;

/// 更改密码
+ (NSString *)getChangePasswordUrl;

/// 登录成功之后更新用户的位置和最后一次登录的时间
+ (NSString *)getLocationRecentStatusUrl;

/// ping++支付
+ (NSString *)getPingPayUrl;

/// ping++退款 
+ (NSString *)getRefundUrl;

/// 首页数据
+ (NSString *)getMainUrl;

/// 获取门店暖场人
+ (NSString *)getAtivitorsUrl;

/// 分页获取门店暖场人
+ (NSString *)getAtivitorsByPageUrl;

/// 获取门店商品
+ (NSString *)getStoreGoodsUrl;

/// 获取门店
+ (NSString *)getStoreUrl;

/// 获取门店在约人数
+ (NSString *)getStoreInvitatorsUrl;

/// 创建订单
+ (NSString *)getCreateOrderUrl;

/// 创建评论
+ (NSString *)getRecentStatusUrl;

/// 获取门店评论
+ (NSString *)getCommentUrl;

@end
