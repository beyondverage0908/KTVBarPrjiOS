//
//  KTVPinZhuoDetail.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVPinZhuoDetail : NSObject

//{
//    "id": 15,
//    "username": "18939865772",
//    "storeType": 0,
//    "storeId": 4,
//    "limitPeople": 5,
//    "description": "2222",
//    "consume": 200,
//    "requiredType": "拼桌",
//    "endTime": "2017-10-01",
//    "status": 0,
//    "userList": []
//}

@property (nonatomic, strong) NSString * pinZhuoId;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, assign) NSInteger storeType;
@property (nonatomic, strong) NSString * storeId;
@property (nonatomic, strong) NSString * limitPeople;
@property (nonatomic, strong) NSString * pzDescription;
@property (nonatomic, strong) NSString * consume;
@property (nonatomic, strong) NSString * requiredType;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray<KTVUser *> * userList;

@end
