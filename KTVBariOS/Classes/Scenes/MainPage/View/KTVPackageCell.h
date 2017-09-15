//
//  KTVPackageCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/10.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KTVGroupbuy.h"
#import "KTVPackage.h"

@interface KTVPackageCell : UITableViewCell

@property (nonatomic, strong)KTVGroupbuy *groupbuy;
@property (nonatomic, strong)KTVPackage *package;

@end
