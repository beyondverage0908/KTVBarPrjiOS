//
//  KTVStore.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStore.h"

@implementation KTVStore

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"activitorList" : [KTVUser class],
             @"pictureList" : [KTVPicture class],
             @"groupBuyList" : [KTVGroupbuy class]};
}
@end
