//
//  KTVBuyNotesCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/22.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KTVStore.h"
#import "KTVGroupbuy.h"

@interface KTVBuyNotesCell : UITableViewCell

@property (strong, nonatomic) KTVStore *store;
@property (strong, nonatomic) KTVGroupbuy *groupbuy;

@end
