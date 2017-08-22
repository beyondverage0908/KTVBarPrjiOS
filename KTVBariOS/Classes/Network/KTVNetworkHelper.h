//
//  KTVNetworkHelper.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVRequestMessage.h"

//请求成功block
typedef void(^RequestSuccess)(NSDictionary *result);
//请求失败block
typedef void(^RequestFailure)(NSError *error);

@interface KTVNetworkHelper : NSObject

+ (instancetype)sharedInstance;
// 发送请求
- (void)send:(KTVRequestMessage *)message success:(RequestSuccess)successBlock fail:(RequestFailure)failBlock;

@end
