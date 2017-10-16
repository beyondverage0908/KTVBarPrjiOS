//
//  KTVOrder.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrder.h"

@implementation KTVOrder

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId" : @"id",
             @"des" : @"description"};
}

// 容器类转换
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"orderDetailList" : [KTVOrderDetail class]};
}

@end
