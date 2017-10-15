//
//  KTVYaoYueUserCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVInvitedUser.h"

@interface KTVYaoYueUserCell : UITableViewCell

@property (nonatomic, strong) KTVInvitedUser * inviteUser;

@property (nonatomic, copy) void (^yueTaCallback)(KTVInvitedUser *inviteUser);
@property (nonatomic, copy) void (^pinzhuoCallback)(KTVInvitedUser *inviteUser);

@end
