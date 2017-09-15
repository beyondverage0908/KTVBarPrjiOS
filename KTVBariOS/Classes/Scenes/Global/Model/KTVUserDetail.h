//
//  KTVUserDetail.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVUserDetail : NSObject

//"userDetail": {
//    "id": 3,
//    "sign": null,
//    "type": 1,
//    "price": 300,
//    "todayMood": "cc",
//    "profession": "技工",
//    "constellation": "金牛座",
//    "status": null,
//    "active": 0
//}

@property (nonatomic, strong) NSString * userDetailId;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSString * todayMood;
@property (nonatomic, strong) NSString * profession;
@property (nonatomic, strong) NSString * constellation;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger active;
@property (nonatomic, strong) NSString *headerUrl;

@end
