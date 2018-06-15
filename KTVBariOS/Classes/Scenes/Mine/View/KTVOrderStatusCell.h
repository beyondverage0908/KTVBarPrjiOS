//
//  KTVOrderStatusCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/11.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVOrder.h"

@interface KTVOrderStatusCell : UITableViewCell

@property (nonatomic, strong) KTVOrder *order;

@property (nonatomic, copy) void (^orderCancelCallBack)(NSString *orderId, NSInteger orderType, BOOL isRefunded);

@end
