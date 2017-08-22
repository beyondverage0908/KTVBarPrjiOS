//
//  KTVPackageCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/10.
//  Copyright © 2017年 Lin. All rights reserved.
//
//  酒吧 - KTV首页 套餐cell

#import "KTVPackageCell.h"

@interface KTVPackageCell ()

@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *alreadySoldNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation KTVPackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
