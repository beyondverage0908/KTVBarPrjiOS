//
//  KTVActivity.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVActivity : NSObject

//{
//    "id": 4,
//    "title": "bb",
//    "content": "bb",
//    "fromTime": "2017-08-13 17:57:17.0",
//    "toTime": "2017-08-24 17:57:26.0",
//    "price": 20,
//    "totalTime": 30,
//    "storeId": 4
//}

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *fromTime;
@property (nonatomic, strong) NSString *toTime;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *totalTime;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) KTVPicture * picture;


@end
