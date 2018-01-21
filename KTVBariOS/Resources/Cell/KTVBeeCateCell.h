//
//  KTVBeeCateCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVBeeCateCell : UITableViewCell

@property (nonatomic, copy) void (^callback)(BOOL isSelected);

@end
