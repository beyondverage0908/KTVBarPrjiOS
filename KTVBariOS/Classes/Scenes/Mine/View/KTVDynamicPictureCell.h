//
//  KTVDynamicPictureCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVDynamicPictureCell : UITableViewCell

@property (nonatomic, copy) void (^seeDynaicCallback)(void);

@end
