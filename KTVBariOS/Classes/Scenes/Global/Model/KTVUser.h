//
//  KTVUser.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVUserDetail.h"
#import "KTVPicture.h"
#import "KTVVideo.h"

@interface KTVUser : NSObject


@property (nonatomic, strong) NSString *account; // 自定义属性

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * realName;
@property (nonatomic, strong) NSString * userCardId;
@property (nonatomic, strong) NSString * des;
@property (nonatomic, strong) NSString * userEmail;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, assign) NSInteger shareTableStatus; // 拼桌状态
@property (nonatomic, assign) NSInteger inviteStatus;   // 邀约状态
@property (nonatomic, strong) NSString *rongCloudToken;   // 融云token


@property (nonatomic, strong) NSString * gender;    // 自定义属性
@property (nonatomic, strong) KTVUserDetail *userDetail;
@property (nonatomic, strong) NSArray<KTVPicture *> * pictureList;
@property (nonatomic, strong) NSArray<KTVVideo *> * videoList;

@end
