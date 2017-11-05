//
//  KTVBanner.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KTVPicture.h"

@interface KTVBanner : NSObject

//{
//    "id": 3,
//    "sort": 3,
//    "picture": {
//        "id": 34,
//        "pictureName": "914403481744310272.jpg",
//        "pictureUrl": "http://127.0.0.1/image/914403481744310272.jpg",
//        "formatType": "image/jpeg",
//        "status": 1
//    },
//    "createTime": null,
//    "description": "ccc"
//}

@property (nonatomic, strong) NSString * bannerId;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) KTVPicture *picture;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * desc;

@end
