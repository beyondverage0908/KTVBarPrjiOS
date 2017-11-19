//
//  KTVVideo.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/18.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVVideo.h"

@implementation KTVVideo

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoId" : @"id"};
}


@end
