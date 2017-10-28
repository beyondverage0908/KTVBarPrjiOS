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

/// 加入拼桌
+ (void)postShareTableEnroll:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 保存用户详情
+ (void)postSaveUserDetail:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 用户上传图片
+ (void)postUploadUserPicture:(NSDictionary *)params result:(ResponseSuccess)responseResult;

/// 创建用户动态
+ (void)postUploadDynamic:(NSDictionary *)params result:(ResponseSuccess)responseResult;

@end
