//
//  KTVStoreCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVStore.h"

@interface KTVStoreCell : UITableViewCell

@property (copy, nonatomic) void (^callBack)(KTVStore *store);
@property (nonatomic, strong) KTVStore *store;

@end
