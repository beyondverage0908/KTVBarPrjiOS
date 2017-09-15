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

@end
