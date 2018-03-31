//
//  KTVMainService.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/6.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseSuccess)(NSDictionary *result);

@interface KTVMainService : NSObject

/// 获取首页数据
+ (void)postMainPage:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取门店暖场人
+ (void)getStoreActivitors:(NSString *)storeId result:(ResponseSuccess)responseResult;

/// 分页获取门店暖场人
+ (void)getStorePageActivitors:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取门店商品
+ (void)getStoreGoods:(NSString *)storeId result:(ResponseSuccess)responseResult;

/// 获取门店
+ (void)getStore:(NSString *)storeId result:(ResponseSuccess)responseResult;

/// 获取门店在约人数
+ (void)getStoreInvitators:(NSString *)storeId result:(ResponseSuccess)responseResult;

/// 创建拼桌
+ (void)postShareTable:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 拼桌地址
+ (void)postShareTableAddress:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取拼桌详情
+ (void)getShareTableDetail:(NSString *)mobileNum result:(ResponseSuccess)responseResult;

/// 按条件查询门店
+ (void)postStoreSearch:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 查询订单
+ (void)postSearchOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 创建邀约
+ (void)postCreateInvite:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取单个邀约
+ (void)getSingleInvite:(NSString *)inviteId result:(ResponseSuccess)responseResult;

/// 邀约大厅数据
+ (void)postNearInvite:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户申请入驻
+ (void)postUserEnter:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 同意用户入驻
+ (void)postAgreeUserEnter:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 添加收藏
+ (void)postUserCollect:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取收藏
+ (void)getUserCollect:(NSString *)mobile result:(ResponseSuccess)responseResult;

/// 取消收藏;
+ (void)postUserCollectCancel:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 加入拼桌
+ (void)postShareTableEnroll:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 保存用户详情
+ (void)postSaveUserDetail:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户上传图片
+ (void)postUploadUserPicture:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户上传头像，背景图
+ (void)postUploadHeader:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 上传用户头像背景图片
+ (void)postUploadHeaderBg:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 编辑昵称
+ (void)postEditNickname:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 创建用户动态
+ (void)postUploadDynamic:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 根据距离查询门店
+ (void)postLocalStore:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 退出注销
+ (void)postAppExit:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 门店猜你喜欢
+ (void)postStoreLike:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 门店附近的活动
+ (void)postStoreNearActivity:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 首页轮播图
+ (void)getMainBanner:(NSString *)params result:(ResponseSuccess)responseResult;

/// 获取最新的版本号
+ (void)getAppVersion:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取附近的普通用户
+ (void)getCommonNearUser:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户上传视频
+ (void)uploadVideo:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 删除相册
+ (void)postDeleteUserPhoto:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 删除图片
+ (void)postDeleteUserVideo:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取用户融云的token
+ (void)getRongCloudToken:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取好友
+ (void)getMyFriend:(NSString *)phone result:(ResponseSuccess)responseResult;

/// 添加好友
+ (void)postAddFriend:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 更新用户最新的地理位置
+ (void)postRecentUserAddress:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 申请暖场人
+ (void)postApplyWarmer:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 申请付款后获取的暖场人
+ (void)postPayAfterWarmer:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 修改暖场人兼职的时间
+ (void)postUpdateWarmerWorkTime:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 附近的暖场人
+ (void)postNearWarmerUser:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 更新用户channelid
+ (void)postUpdateBPushChannel:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 获取兼职暖场人的订单
+ (void)postWarmerUserOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 设置兼职暖场人接受和拒绝
+ (void)postUpdateRejectRecordOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 查询兼职暖场人的拒绝和接受订单
+ (void)postQueryRejectRecordOrderUrl:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 创建暖场人订单
+ (void)postCreateWarmerOrder:(NSDictionary *)params result:(ResponseSuccess)responseResult;
@end
