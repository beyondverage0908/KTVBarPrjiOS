//
//  KTVUserHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KTVUserHeaderCellDelegate <NSObject>

// 登陆
- (void)gotoLogin;

// 查看个人信息
- (void)toseeMineInfo:(NSDictionary *)info;

@end

@interface KTVUserHeaderCell : UITableViewCell

@property (weak, nonatomic)id<KTVUserHeaderCellDelegate> delegate;

@end
