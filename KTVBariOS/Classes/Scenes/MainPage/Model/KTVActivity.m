//
//  KTVActivity.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVActivity.h"

@implementation KTVActivity

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"activityId" : @"id"};
}

@end
