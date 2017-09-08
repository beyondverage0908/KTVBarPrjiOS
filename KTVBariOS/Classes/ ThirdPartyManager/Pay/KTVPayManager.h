//
//  KTVPayManager.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KTVPayType) {
    AlipayType,
    WeChatType,
    UnionPayType
};

@interface KTVPayManager : NSObject

/**
 *  @param payType 支付类型
 *  @param charge 服务端返回的
 *  @param controller 当前试图对象 - 银联支付需要，其他支付传nil
 *  @param completion 支付回调
 */
+ (void)ktvPay:(KTVPayType)payType
       payment:(NSObject *)charge
     contoller:(UIViewController *)controller
    completion:(void (^)(NSString *result))completion;

@end
