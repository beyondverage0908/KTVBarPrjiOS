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
@property (nonatomic, strong) UIImage * headerImage;

// 选择背景图
@property (nonatomic, copy) void (^pickHeaderBgImageCallback)(void);
// 选择头像
@property (nonatomic, copy) void (^pickHeaderImageCallback)(void);

@end
