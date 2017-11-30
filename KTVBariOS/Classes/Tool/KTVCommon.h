//
//  KTVCommon.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVUser.h"
#import "KTVAddress.h"

@interface KTVCommon : NSObject
/// 判断用户是否登陆状态
+ (BOOL)isLogin;
/// 获取用户信息
+ (KTVUser *)userInfo;
/// 删除用户信息
+ (void)resignUserInfo;
/// 保存用户信息
+ (void)saveUserInfo:(NSDictionary *)userInfo;
/// 设置用户信息
+ (void)setUserInfoKey:(NSString *)infoKey infoValue:(NSString *)infoValue;
/// 获取token
+ (NSString *)ktvToken;
/// 移除token
+ (void)removeKtvToken;
/// 以key值为 lat:long(纬经)
+ (void)saveUserLocation:(NSString *)locationString;
/// 返回经纬度数组，纬度为第一个元素，经度为第二个元素，获取不到则为nil
+ (KTVAddress *)getUserLocation;

@end
