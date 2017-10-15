//
//  KTVInvitedUser.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVInvitedUser.h"

@implementation KTVInvitedUser

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"user" : @"userModel"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSInteger distance = [dic[@"distance"] integerValue];
    _distance = [NSString stringWithFormat:@"%@", @(distance)];
    
    return YES;
}


@end
