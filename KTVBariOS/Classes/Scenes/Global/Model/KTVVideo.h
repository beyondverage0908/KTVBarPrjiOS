//
//  KTVVideo.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/11/18.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVVideo : NSObject

//{
//    formatType = "image/png";
//    id = 1;
//    size = 3529099;
//    status = 1;
//    url = "http://119.23.148.104/image/930796841744728064.png";
//    videoName = "930796841744728064.png";
//    videoType = 1;
//}

@property (nonatomic, strong) NSString *formatType;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, assign) NSInteger videoType;


@end
