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

#pragma mark - 用户

/// 获取用户信息
+ (NSString *)getUserInfoUrl;

/// 保存用户详情
+ (NSString *)getSaveUserDetailUrl;

/// 用户上传图片
+ (NSString *)getUploadUserPictureUrl;

#pragma mark - 用户动态

+ (NSString *)getUserDynamicStatementUrl;

+ (NSString *)getUserDynamicStatementListUrl;

#pragma mark - 登陆

/// 获取验证码
+ (NSString *)getIdentifyingCodeUrl;

/// 核对验证码url
+ (NSString *)getCheckIndentifyCodeUrl;

/// 一般登录（手机号+密码）
+ (NSString *)getCommonLoginUrl;

/// 手机快捷登陆
+ (NSString *)getPhoneLoginUrl;

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

#pragma mark - 门店

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

/// 按条件查询门店
+ (NSString *)getStoreSearchUrl;

/// 获取门店附近的活动
+ (NSString *)getStoreNearActivityUrl;

/// 获取单个团购信息
+ (NSString *)getGroupBuyUrl;

#pragma mark - 订单

/// 创建订单
+ (NSString *)getCreateOrderUrl;

/// 获取订单
+ (NSString *)getOrderUrl;

/// 更改订单状态
+ (NSString *)getOrderUpdateStatusUrl;

/// 查询订单 
+ (NSString *)getSearchOrderUrl;

#pragma mark - 评论

/// 创建评论
+ (NSString *)getRecentStatusUrl;

/// 获取门店评论
+ (NSString *)getCommentUrl;

#pragma mark - 拼桌

/// 创建拼桌
+ (NSString *)getCreatShareTableUrl;

/// 拼桌地址
+ (NSString *)getShareTableAddressUrl;

/// 获取拼桌详情
+ (NSString *)getShareTableDetailUrl;

/// 加入拼桌
+ (NSString *)getShareTableEnrollUrl;

#pragma mark - 邀约

/// 创建邀约
+ (NSString *)getCreateInviteUrl;

/// 获取单个邀约
+ (NSString *)getSingleInviteUrl;

/// 邀约大厅数据
+ (NSString *)getNearInviteUrl;

#pragma mark - 用户入驻

/// 用户申请入驻
+ (NSString *)getUserEnterUrl;

/// 同意用户入驻
+ (NSString *)getAgreeUserEnterUrl;

#pragma mark - 收藏

/// 添加收藏
+ (NSString *)getUserCollectUrl;

/// 获取收藏
+ (NSString *)getAlreadyCollectUrl;

@end
