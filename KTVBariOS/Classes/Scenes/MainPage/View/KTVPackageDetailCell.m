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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
