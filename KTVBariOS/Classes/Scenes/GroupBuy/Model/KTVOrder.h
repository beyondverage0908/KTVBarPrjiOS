//
//  KTVOrder.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVUser.h"
#import "KTVStore.h"
#import "KTVOrderDetail.h"

@interface KTVOrder : NSObject

@property (nonatomic, strong) NSString * orderId;
@property (nonatomic, assign) NSInteger orderType;
@property (nonatomic, strong) KTVUser * user;
@property (nonatomic, strong) KTVStore * store;
@property (nonatomic, strong) NSString * subOrderId;
@property (nonatomic, strong) NSString * allMoney;
@property (nonatomic, strong) NSString * discountMoney;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, strong) NSArray<KTVOrderDetail *> * orderDetailList;
@property (nonatomic, assign) BOOL userHide;
@property (nonatomic, strong) NSString * usePassword;
@property (nonatomic, strong) NSString * des;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * changeId;

@end
