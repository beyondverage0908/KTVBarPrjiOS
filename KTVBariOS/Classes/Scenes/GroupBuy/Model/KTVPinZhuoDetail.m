//
//  KTVPinZhuoDetail.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPinZhuoDetail.h"

@implementation KTVPinZhuoDetail

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pinZhuoId" : @"id",
             @"pzDescription" : @"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"userList" : [KTVUser class]};
}

@end
