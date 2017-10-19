//
//  KTVGroupBuyHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/21.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVStore.h"
#import "KTVGroupbuy.h"

@interface KTVGroupBuyHeaderCell : UITableViewCell

@property (nonatomic, strong) KTVStore *store;        // 门店详情
@property (nonatomic, strong) NSArray *invitatorList; // 在约小伙伴列表
@property (nonatomic, strong) KTVGroupbuy *groupbuy;

@property (nonatomic, copy) void (^bookedGroupbuyCallback)(void);
@property (nonatomic, copy) void (^yueCallback)(KTVStore *store);   // 在约的小伙伴xx人

@end
