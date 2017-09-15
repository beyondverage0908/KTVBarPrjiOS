//
//  KTVUserDetail.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserDetail.h"

@implementation KTVUserDetail

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userDetailId" : @"id"};
}

@end
