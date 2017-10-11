//
//  KTVGood.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGood.h"

@implementation KTVGood

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodId" : @"id"};
}

// 容器类转换
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"pictureList" : [KTVPicture class]};
}

@end
