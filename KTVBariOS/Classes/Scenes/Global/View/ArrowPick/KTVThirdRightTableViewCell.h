//
//  ThirdRightTableViewCell.h
//  Frame
//
//  Created by 栗子 on 2017/9/7.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTVThirdRightTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *iconIV;
@property(nonatomic,strong) UILabel *titleLB;

- (void)iconiv:(UIImage *)image titleText:(NSString *)text;

@end
