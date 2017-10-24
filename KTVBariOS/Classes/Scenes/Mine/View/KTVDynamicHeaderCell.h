//
//  KTVDynamicHeaderCell.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVDynamicHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImage * headerBgImage;

@property (nonatomic, copy) void (^pickHeaderBgImageCallback)(void);

@end