//
//  KTVOrderDetail.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVOrderDetail : NSObject

//{
//    "id":129,
//    "orderType":2,
//    "sourceId":34,
//    "count":1,
//    "price":100,
//    "discount":100
//}

@property (nonatomic, strong) NSString * orderDetailId;
@property (nonatomic, assign) NSInteger orderType;
@property (nonatomic, strong) NSString * sourceId;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger discount;

@end
