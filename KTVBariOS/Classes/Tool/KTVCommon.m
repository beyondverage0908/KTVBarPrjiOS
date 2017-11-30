//
//  KTVCommon.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVCommon.h"


@implementation KTVCommon

+ (BOOL)isLogin {
    if ([KTVCommon userInfo].phone && [KTVCommon ktvToken]) {
        return YES;
    } else {
        return NO;
    }
}

+ (KTVUser *)userInfo {
    NSDictionary *userInfo = [KTVUtil objectForKey:@"ktvUserInfo"];
    KTVUser *user = [KTVUser yy_modelWithDictionary:userInfo];
    return user;
}

+ (void)resignUserInfo {
    [KTVUtil removeUserDefaultForKey:@"ktvUserInfo"];
    [self removeKtvToken];
}

+ (void)removeKtvToken {
    [KTVUtil removeUserDefaultForKey:@"ktvToken"];
}

+ (void)setUserInfoKey:(NSString *)infoKey infoValue:(NSString *)infoValue {
    NSDictionary *info = [KTVUtil objectForKey:@"ktvUserInfo"];
    if (!info) {
        info = [NSDictionary dictionary];
    }
    NSMutableDictionary *muUserInfo = [NSMutableDictionary dictionaryWithDictionary:info];
    if (!infoKey) {
        [muUserInfo removeObjectForKey:infoKey];
    }
    if (infoValue) {
        [muUserInfo setObject:infoValue forKey:infoKey];
    }
    if ([info[infoKey] isEqualToString:infoValue]) {
        return;
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:muUserInfo];
    [KTVUtil setObject:userInfo forKey:@"ktvUserInfo"];
}

+ (void)saveUserInfo:(NSDictionary *)userInfo {
    [KTVUtil setObject:userInfo forKey:@"ktvUserInfo"];
}

+ (NSString *)ktvToken {
    return [KTVUtil objectForKey:@"ktvToken"];
}

+ (void)saveUserLocation:(NSString *)locationString {
    [KTVUtil setObject:locationString forKey:@"lat:long"];
}

+ (KTVAddress *)getUserLocation {
    NSString *latlong = [KTVUtil objectForKey:@"lat:long"];
    NSArray *locationArr = nil;
    if (latlong) {
        locationArr = [latlong componentsSeparatedByString:@":"];
    }
    KTVAddress *address = [[KTVAddress alloc] init];
    address.latitude = [[locationArr firstObject] doubleValue];
    address.longitude = [[locationArr lastObject] doubleValue];
    return address;
}

@end
