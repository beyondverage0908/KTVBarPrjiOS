//
//  KTVBeeCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVNearUser.h"

@interface KTVBeeCell : UITableViewCell

@property (nonatomic, strong) KTVNearUser * nearUser;
@property (nonatomic, copy) void (^enterStoreCallback)(KTVNearUser *user);

@end
