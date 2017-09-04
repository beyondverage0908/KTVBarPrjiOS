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
}
@end
