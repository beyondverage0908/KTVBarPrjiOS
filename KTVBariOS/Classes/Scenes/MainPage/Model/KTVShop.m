//
//  KTVShop.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/9.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVShop.h"

@implementation KTVShop

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"good" : @"goodKey"};
}

@end
