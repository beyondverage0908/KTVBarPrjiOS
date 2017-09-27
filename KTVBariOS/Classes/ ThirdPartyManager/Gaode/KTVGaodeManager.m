//
//  KTVGaodeManager.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGaodeManager.h"

@interface KTVGaodeManager ()<AMapLocationManagerDelegate, AMapSearchDelegate>

@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (strong, nonatomic) AMapSearchAPI *search;

@property (nonatomic, copy) void (^reGencodeComplectionBlock)(AMapReGeocode *reGencode);

@end

@implementation KTVGaodeManager

static KTVGaodeManager *_instance = nil;

+ (instancetype)defaultGaode {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[KTVGaodeManager alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configLocationManager];
        [self configSearch];
    }
    return self;
}

- (NSString *)getGaodeMapKey {
    return @"16c0f6cf4e8864a812baccfd88135528";
}

- (void)configLocationManager{
    [AMapServices sharedServices].apiKey = [self getGaodeMapKey];
    
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    self.locationManager.distanceFilter = 20;
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setLocatingWithReGeocode:YES];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setLocationTimeout:6];
    [self.locationManager setReGeocodeTimeout:3];
}

- (void)startSerialLocation {
    //开始定位
    [self.locationManager startUpdatingLocation];
}

//1、两点间的直线距离计算
//根据用户指定的两个经纬度坐标点，计算这两个点间的直线距离，单位为米。代码如下:
+ (CLLocationDistance)distanceMeterCoordinate:(CLLocation *)pointA toPoint:(CLLocation *)pointB {
    CLLocationDistance distance = [pointA distanceFromLocation:pointB];
    return distance;
}

- (void)locateReGeocodeOnceAction {
    //带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //定位信息
        NSLog(@"location:%@", location);
        
        //逆地理信息
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    if (reGeocode) {
        NSLog(@"reGeocode:%@; formattedAddress:%@; street:%@", reGeocode, reGeocode.formattedAddress, reGeocode.street);
    }
    
    NSString *loc = [NSString stringWithFormat:@"%@:%@", @(location.coordinate.latitude), @(location.coordinate.longitude)];
    [KTVCommon saveUserLocation:loc];
    // 停止定位
    if(location) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"gaode location fail");
}

#pragma mark - 逆地理编码

- (void)configSearch {
    [AMapServices sharedServices].apiKey = [self getGaodeMapKey];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (void)startReGeocodeWithLocation:(KTVAddress *)location completionBlock:(void (^)(AMapReGeocode *reGencode))completionBlock {
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:location.latitude
                                              longitude:location.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
    
    if (completionBlock) {
        self.reGencodeComplectionBlock = completionBlock;
    }
}

#pragma mark - 逆地理编码 - 代理回调

//当逆地理编码成功时，会进到 onReGeocodeSearchDone 回调函数中，通过解析 AMapReGeocodeSearchResponse 获取这个点的地址信息（包括：标准化的地址、附近的POI、面区域 AOI、道路 Road等）。
//1）可以在回调中解析 response，获取地址信息。
//2）通过 response.regeocode 可以获取到逆地理编码对象 AMapReGeocode。
//3）通过 AMapReGeocode.formattedAddress 返回标准化的地址，AMapReGeocode.addressComponent 返回地址组成要素，包括：省名称、市名称、区县名称、乡镇街道等。
//4）AMapReGeocode.roads 返回地理位置周边的道路信息。
//5）AMapReGeocode.pois 返回地理位置周边的POI（大型建筑物，方便定位）。
//6）AMapReGeocode.aois 返回地理位置所在的AOI（兴趣区域）。

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        //解析response获取地址描述
        if (self.reGencodeComplectionBlock) {
            self.reGencodeComplectionBlock(response.regeocode);
        }
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    //解析response获取地址描述
    if (self.reGencodeComplectionBlock) {
        self.reGencodeComplectionBlock(nil);
    }
}

@end
