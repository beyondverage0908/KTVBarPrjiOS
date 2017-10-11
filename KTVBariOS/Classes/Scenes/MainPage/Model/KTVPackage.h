//
//  KTVPackage.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/15.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KTVGood.h"

@interface KTVPackage : NSObject

//{
//    "id": 1,
//    "title": "订39起，××××××××××××××××",
//    "packageName": "bbbb",
//    "price": 600,
//    "realPrice": 888,
//    "goodList": [
//                 {
//                     "id": 1,
//                     "goodName": "aa",
//                     "picture": {
//                         "id": 1,
//                         "pictureName": null,
//                         "pictureUrl": "http://localhost:8099/images/Z.jpg",
//                         "height": null,
//                         "width": null,
//                         "formatType": null,
//                         "pictureIndex": 0,
//                         "status": null
//                     },
//                     "goodPrice": 100,
//                     "stock": 12,
//                     "discount": 23,
//                     "pictureList": []
//                 }
//                 ],
//    "timeLength": 8,
//    "belong": "大包 13:00~18：00欢唱6小时",
//    "buyTime": "01:00~02:00;08:00~09:00",
//    "notice": "aaaa"
//}

@property (nonatomic, strong) NSString *packageId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *packageName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *realPrice;
@property (nonatomic, strong) NSArray<KTVGood *> *goodList;
@property (nonatomic, strong) NSString *timeLength;
@property (nonatomic, strong) NSString *belong;
@property (nonatomic, strong) NSString *buyTime;
@property (nonatomic, strong) NSString *notice;

@property (nonatomic, assign) BOOL isSelected; // 自定义字段，用户是否选择该套餐

@end
