//
//  KTVPayEndCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVPayEndCell : UITableViewCell

@property (nonatomic, copy) void (^completedCallback)(void);
@property (nonatomic, copy) void (^startPinZhuoCallback)(void);

@end
