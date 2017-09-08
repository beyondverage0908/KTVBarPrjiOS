//
//  KTVBuyService.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/6.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求成功block
typedef void(^ResponseSuccess)(NSDictionary *result);

@interface KTVBuyService : NSObject

/// 支付接口
+ (void)postPayParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

@end
