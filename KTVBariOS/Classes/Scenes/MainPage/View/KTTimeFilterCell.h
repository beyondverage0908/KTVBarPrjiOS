//
//  KTVScrollTimeCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTTimeFilterCell : UITableViewCell

@property (nonatomic, copy) void (^filterCallback)(NSInteger idx);

- (instancetype)initWithItems:(NSArray *)items reuseIdentifier:(NSString *)reuseIdentifier;

@end
