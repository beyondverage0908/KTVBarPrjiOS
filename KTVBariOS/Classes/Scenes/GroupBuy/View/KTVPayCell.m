//
//  KTVPayCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPayCell.h"

@interface KTVPayCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel; //  剩余支付时间倒计时 - 需要写方法
@property (weak, nonatomic) IBOutlet UILabel *leftTimeTipLabel; // 剩余支付时间提示

@end

@implementation KTVPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
