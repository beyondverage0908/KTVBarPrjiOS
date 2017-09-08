//
//  ThirdRightTableViewCell.m
//  Frame
//
//  Created by 栗子 on 2017/9/7.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import "KTVThirdRightTableViewCell.h"

@implementation KTVThirdRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconIV = [[UIImageView alloc] init];
        self.titleLB = [[UILabel alloc] init];
    }
    return self;
}

- (void)iconiv:(UIImage *)image titleText:(NSString *)text{
    
    if (image) {
        self.iconIV.frame = CGRectMake(5, 10, 30, 30);
        [self.contentView addSubview:self.iconIV];
        self.iconIV.layer.cornerRadius = 25;
        self.iconIV.layer.masksToBounds = YES;
        
        self.titleLB.frame = CGRectMake(CGRectGetMaxX(self.iconIV.frame) + 10, 15, 200, 20);
        [self.contentView addSubview:self.titleLB];
    } else {
        self.titleLB.frame = CGRectMake(20, 0, 250, self.contentView.frame.size.height);
        [self.contentView addSubview:self.titleLB];
    }
    self.iconIV.image = image;
    self.titleLB.text = text;
}

@end
