//
//  KTVPicture.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVPicture : NSObject

//{
//    "id": 2,
//    "pictureName": null,
//    "pictureUrl": "http://localhost:8080/images/ooo.jpg",
//    "height": null,
//    "width": null,
//    "formatType": null,
//    "pictureIndex": 0,
//    "status": null
//}

@property (nonatomic, strong) NSString * pictureId;
@property (nonatomic, strong) NSString *pictureName;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) NSInteger formatType;
@property (nonatomic, assign) NSInteger pictureIndex;
@property (nonatomic, assign) NSInteger status;

@end
