//
//  KTVPackage.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackage.h"

@implementation KTVPackage

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"packageId" : @"id"};
}

@end
