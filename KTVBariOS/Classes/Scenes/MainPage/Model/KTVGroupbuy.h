//
//  KTVGroupbuy.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVGroupbuy : NSObject

//{
//    "id": 20,
//    "title": "1",
//    "totalPrice": 100,
//    "startTime": null,
//    "endTime": null,
//    "buyNotice": "有效期1",
//    "remark": "规则提醒1",
//    "notice": "温馨提示1",
//    "timeLength": 1,
//    "groupByTypeName": "1",
//    "storeType": 0,
//    "groupBuyTime": "08:00~09:00",
//    "username": null
//}

@property (nonatomic, strong) NSString *groupbuyId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *buyNotice;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *timeLength;
@property (nonatomic, strong) NSString *groupByTypeName;
@property (nonatomic, assign) NSInteger storeType;
@property (nonatomic, strong) NSString *groupBuyTime;
@property (nonatomic, strong) NSString *username;

@end
