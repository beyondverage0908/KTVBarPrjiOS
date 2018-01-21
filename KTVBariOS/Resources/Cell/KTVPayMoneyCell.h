//
//  KTVPayMoneyCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVPayMoneyCell : UITableViewCell

@property (nonatomic, assign) double money;
@property (nonatomic, copy) void (^payMoneyAction)(double money);

@end
