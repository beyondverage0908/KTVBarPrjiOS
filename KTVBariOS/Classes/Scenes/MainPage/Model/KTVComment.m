//
//  KTVComment.m
//  AFNetworking
//
//  Created by pingjun lin on 2018/6/11.
//

#import "KTVComment.h"

@implementation KTVComment

// 属性转换 - 服务端返回的属性和需要定义的属性不一致
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"commentId" : @"id", @"desc" : @"description"};
}

@end
