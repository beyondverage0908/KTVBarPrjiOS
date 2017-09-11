//
//  KTVUser.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUser.h"

@implementation KTVUser

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([dic[@"sex"] integerValue] == 0) {
        _gender = @"女";
    }
    if ([dic[@"sex"] integerValue] == 1) {
        _gender = @"男";
    }
    
    return YES;
}

@end
