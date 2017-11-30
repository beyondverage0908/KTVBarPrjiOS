//
//  KTVUserBannerCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVUserBannerCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelf;;
@property (nonatomic, strong) KTVUser * user;

// 添加好友回调
@property (nonatomic, copy) void (^addFriendCallback)(KTVUser *user);

@end
