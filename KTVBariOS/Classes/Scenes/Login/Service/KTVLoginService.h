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

/// 获取验证码
+ (void)getIdentifyingCodeParams:(NSDictionary *)params result:(ResponseSuccess)result;

/// 普通登陆
+ (void)getCommonLoginParams:(NSDictionary *)params result:(ResponseSuccess)responseResult;

@end
