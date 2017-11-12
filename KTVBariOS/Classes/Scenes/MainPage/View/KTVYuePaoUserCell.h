//
//  KTVYuePaoUserCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVUser.h"

typedef enum : NSUInteger {
    KTVUserActivity,    // 小蜜蜂
    KTVUserInvitate,     // 邀约用户
    KTVUserCommon      // 普通用户
} KTVUserType;

@interface KTVYuePaoUserCell : UITableViewCell

@property (nonatomic, assign) KTVUserType userType;
@property (nonatomic, strong) KTVUser *user;

@property (nonatomic, copy) void (^yueCallback)(KTVUser *user, BOOL isSelected);

@end
