//
//  KTVPackageDetailCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPackageDetailCell.h"

@interface KTVPackageDetailCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabe;
@property (weak, nonatomic) IBOutlet UILabel *selectTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;


@end

@implementation KTVPackageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)selectAction:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    // 同步套餐选择
    self.package.isSelected = sender.isSelected;
    
    if (self.selectCallback) {
        self.selectCallback(self.package, self.package.isSelected);
    }
}

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    if (_package.isSelected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    [self.selectBtn setSelected:_package.isSelected];
    
    self.moneyLabe.text = _package.price;
    self.oldMoneyLabel.text = _package.realPrice;
    self.selectTimeLabel.text = _package.belong;
}
@end
