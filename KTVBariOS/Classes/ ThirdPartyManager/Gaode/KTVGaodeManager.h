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

@interface KTVGaodeManager : NSObject

- (void)startAMapLocation;

+ (CLLocationDistance)distanceMeterCoordinate:(CLLocation *)pointA toPoint:(CLLocation *)pointB;

@end
