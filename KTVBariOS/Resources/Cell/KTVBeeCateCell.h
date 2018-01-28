//
//  KTVBeeCateCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVUser.h"

@interface KTVBeeCateCell : UITableViewCell

@property (nonatomic, copy) void (^callback)(KTVUser *user, BOOL isSelected);
@property (nonatomic, strong) KTVUser * user;

@end
