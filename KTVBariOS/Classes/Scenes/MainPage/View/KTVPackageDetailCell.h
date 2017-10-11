//
//  KTVPackageDetailCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTVPackage.h"

@interface KTVPackageDetailCell : UITableViewCell

@property (nonatomic, strong) KTVPackage * package;

// 选择套餐毁掉，package：选中的套餐 isSelected: 是否选中
@property (nonatomic, copy) void (^selectCallback)(KTVPackage *package, BOOL isSelected);

@end
