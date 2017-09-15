//
//  KTVUser.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTVUserDetail.h"

@interface KTVUser : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) KTVUserDetail *userDetail;

@end
