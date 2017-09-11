//
//  KTVStoreContainer.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVStoreContainer.h"

@implementation KTVStoreContainer

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"userList" : [KTVUser class]};
}

@end
