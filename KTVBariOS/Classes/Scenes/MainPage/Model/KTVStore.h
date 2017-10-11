//
//  KTVStore.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVAddress.h"
#import "KTVUser.h"
#import "KTVPicture.h"
#import "KTVGroupbuy.h"
#import "KTVPackage.h"

@interface KTVStore : NSObject

@property (nonatomic, strong) NSString * storeId;
@property (nonatomic, strong) NSString * storeName;
@property (nonatomic, assign) NSInteger  star;
@property (nonatomic, strong) NSString * fromTime;
@property (nonatomic, strong) NSString * toTime;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * provice;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, assign) NSInteger  storeType;
@property (nonatomic, strong) NSArray  * packageList;
@property (nonatomic, strong) NSArray * seatList;
@property (nonatomic, strong) NSArray * boxRoomList;
@property (nonatomic, strong) NSArray * activitorList;
@property (nonatomic, strong) NSArray * pictureList;
@property (nonatomic, strong) NSArray * groupBuyList;
@property (nonatomic, strong) KTVUser * user;
@property (nonatomic, assign) BOOL showGroupbuy; // 自定义属性，默认不显示团购

@property (nonatomic, strong) KTVAddress * address;

@end
