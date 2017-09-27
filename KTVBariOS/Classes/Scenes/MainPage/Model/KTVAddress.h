//
//  KTVAddress.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVAddress : NSObject

@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString * addressName;
@property (nonatomic, strong) NSString * cityCode;
@property (nonatomic, strong) NSString * cityName;

@end
