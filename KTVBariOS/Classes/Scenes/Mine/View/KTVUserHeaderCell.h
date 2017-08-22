//
//  KTVUserHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KTVUserHeaderCellDelegate <NSObject>

- (void)gotoLogin;

@end

@interface KTVUserHeaderCell : UITableViewCell

@property (weak, nonatomic)id<KTVUserHeaderCellDelegate> delegate;

@end
