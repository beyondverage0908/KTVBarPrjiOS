//
//  KTVYuePaoUserCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVUser.h"

@interface KTVYuePaoUserCell : UITableViewCell

@property (nonatomic, strong) KTVUser *user;

@property (nonatomic, copy) void (^yueCallback)(KTVUser *user, BOOL isSelected);

@end
