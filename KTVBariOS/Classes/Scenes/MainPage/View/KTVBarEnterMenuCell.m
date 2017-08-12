//
//  KTVBarEnterMenuCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBarEnterMenuCell.h"

@interface KTVBarEnterMenuCell ()


@end

@implementation KTVBarEnterMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupView {
    UIView *bottomLine = [[UIView alloc] init];
    [self.contentView addSubview:bottomLine];
    bottomLine.layer.shadowOffset = CGSizeMake(1.0, 2.0);
    bottomLine.layer.shadowColor = [UIColor blackColor].CGColor;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1.0f);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];
    
    UIView *centerVerticalLine = [[UIView alloc] init];
    [self.contentView addSubview:centerVerticalLine];
    centerVerticalLine.layer.shadowOffset = CGSizeMake(1.0, 2.0);
    centerVerticalLine.layer.shadowColor = [UIColor blackColor].CGColor;
    [centerVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// 进入酒吧
- (IBAction)enterBarAction:(UIButton *)sender {
    CLog(@"首页 - 进入酒吧");
}

// 进入ktv
- (IBAction)enterKTVAction:(UIButton *)sender {
    CLog(@"首页 - 进入ktv")
}
@end
