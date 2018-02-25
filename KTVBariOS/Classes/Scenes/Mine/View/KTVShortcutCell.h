//
//  KTVShortcutCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/2/25.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVShortcutCell : UITableViewCell

// tag == 0 : 订单 -- tag == 1 ： 好友
@property (nonatomic, copy) void (^entranceCallback)(NSInteger tag);

@end
