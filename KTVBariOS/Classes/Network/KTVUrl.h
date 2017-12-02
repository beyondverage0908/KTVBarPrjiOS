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

/// 用户上传头像
+ (NSString *)getUploadHeaderUrl;

/// 用户背景图
+ (NSString *)getUploadHeaderBgUrl;

/// 修改昵称
+ (NSString *)getEditNicknameUrl;

/// 获取附近的普通用户
+ (NSString *)getCommonNearUserUrl;

/// 上传视频
+ (NSString *)getUploadVideoUrl;

/// 删除用户图片
+ (NSString *)getDeletePictureUrl;

/// 删除视频
+ (NSString *)getDeleteVideoUrl;

/// 获取用户融云的token
+ (NSString *)getRongCloudTokenUrl;

/// 添加好友
+ (NSString *)getAddFriendUrl;

/// 我的好友
+ (NSString *)getMyFriendUrl;

/// 及时更新用户的地址
+ (NSString *)getRecentUserAddressUrl;

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

/// 退出
+ (NSString *)getExitUrl;

#pragma mark - 支付

/// ping++支付
+ (NSString *)getPingPayUrl;

/// ping++退款 
+ (NSString *)getRefundUrl;

#pragma mark - 首页

/// 首页数据
+ (NSString *)getMainUrl;

/// 首页轮播图
+ (NSString *)getMainBannerUrl;

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

/// 门店-猜你喜欢
+ (NSString *)getStoreLikeUrl;

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

/// 根据距离查询门店
+ (NSString *)getLocalOrderUrl;

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

#pragma mark - 版本号管理

/// 获取最新的版本号
+ (NSString *)getAppVersionUrl;

@end
