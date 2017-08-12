//
//  KTVGaodeManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGaodeManager.h"

@interface KTVGaodeManager ()<AMapLocationManagerDelegate>

@property (strong, nonatomic)AMapLocationManager *locationManager;

@end

@implementation KTVGaodeManager

- (void)startAMapLocation {
    [AMapServices sharedServices].apiKey =@"您的key";

    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 20;
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

//1、两点间的直线距离计算
//根据用户指定的两个经纬度坐标点，计算这两个点间的直线距离，单位为米。代码如下:
+ (CLLocationDistance)distanceMeterCoordinate:(CLLocation *)pointA toPoint:(CLLocation *)pointB {
    CLLocationDistance distance = [pointA distanceFromLocation:pointB];
    return distance;
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode) {
        NSLog(@"reGeocode:%@; formattedAddress:%@; street:%@", reGeocode, reGeocode.formattedAddress, reGeocode.street);
    }
    
    NSString *loc = [NSString stringWithFormat:@"%@:%@", @(location.coordinate.latitude), @(location.coordinate.longitude)];
    [KTVUtil setObject:loc forKey:@"lat:long"];
    // 停止定位
    if(location) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"gaode location fail");
}

@end
