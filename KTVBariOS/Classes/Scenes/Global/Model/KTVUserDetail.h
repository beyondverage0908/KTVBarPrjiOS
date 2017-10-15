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
//    "id": 4,
//    "sign": "abcdfdsfsdfsdfs",
//    "price": 500,
//    "todayMood": "今天很开心",
//    "profession": "老师",
//    "constellation": "白羊座",
//    "status": 1,
//    "active": 1,
//    "income": 20000,
//    "hobby": "喝酒 聊天",
//    "satisfiedFigure": "手",
//    "viewForLove": "爱情",
//    "viewForSex": "xx"
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
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *hobby;
@property (nonatomic, strong) NSString *satisfiedFigure;
@property (nonatomic, strong) NSString *viewForLove;
@property (nonatomic, strong) NSString *viewForSex;

@end
