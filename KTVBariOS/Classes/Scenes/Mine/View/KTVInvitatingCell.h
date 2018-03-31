//
//  KTVInvitatingCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVWarmerOrder.h"

@interface KTVInvitatingCell : UITableViewCell

@property (nonatomic, strong) KTVWarmerOrder *warmerOrder;

@property (nonatomic, copy) void (^agreeCallback)(KTVWarmerOrder *warmerOrder);
@property (nonatomic, copy) void (^denyCallback)(KTVWarmerOrder *warmerOrder);

@end
