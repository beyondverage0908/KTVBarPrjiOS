//
//  KTVGood.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVPicture.h"

@interface KTVGood : NSObject

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

@property (nonatomic, strong) NSString *goodId;
@property (nonatomic, strong) NSString *goodName;
@property (nonatomic, strong) KTVPicture *picture;
@property (nonatomic, strong) NSString *goodPrice;
@property (nonatomic, strong) NSString *stock;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSArray<KTVPicture *> *pictureList;

@end
