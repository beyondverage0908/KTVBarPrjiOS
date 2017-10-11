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

- (void)setGroupbuy:(KTVGroupbuy *)groupbuy {
    _groupbuy = groupbuy;
    
    [self.orderBtn setImage:[UIImage imageNamed:@"app_order_tuan"] forState:UIControlStateNormal];
    self.packageNameLabel.text = _groupbuy.title;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@", _groupbuy.totalPrice];
}

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    [self.orderBtn setImage:[UIImage imageNamed:@"app_order_ding"] forState:UIControlStateNormal];
    self.packageNameLabel.text = _package.packageName;
    self.moneyLabel.text = _package.price;
    self.oldMoneyLabel.text = _package.realPrice;
}

@end
