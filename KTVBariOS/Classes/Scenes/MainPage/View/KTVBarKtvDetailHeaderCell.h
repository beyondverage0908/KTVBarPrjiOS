//
//  KTVBarKtvDetailHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/12.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVStore.h"

@interface KTVBarKtvDetailHeaderCell : UITableViewCell

@property (nonatomic, strong) KTVStore * store;
@property (nonatomic, strong) NSArray<KTVUser *> *invitorList;

@property (nonatomic, copy) void (^callback)(KTVStore *store);
@property (nonatomic, copy) void (^purikuraCallBack)(KTVStore *store);

@end
