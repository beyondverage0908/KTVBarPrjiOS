//
//  KTVPayCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVStore.h"

@interface KTVPayCell : UITableViewCell

@property (nonatomic, strong) NSString *allMoney;
@property (nonatomic, strong) KTVStore *store;

@end
