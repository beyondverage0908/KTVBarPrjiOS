//
//  KTVGaodeManager.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "KTVAddress.h"

@interface KTVGaodeManager : NSObject

+ (instancetype)defaultGaode;

/// 开始持续定位(地位成功后结束定位)
- (void)startSerialLocation;

/// 一次逆地理编码解析，基于用户当前地理位置
- (void)locateReGeocodeOnceAction;

/// 开始逆地理位置编码解析
- (void)startReGeocodeWithLocation:(KTVAddress *)location completionBlock:(void (^)(AMapReGeocode *reGencode))completionBlock;

+ (CLLocationDistance)distanceMeterCoordinate:(CLLocation *)pointA toPoint:(CLLocation *)pointB;

@end
