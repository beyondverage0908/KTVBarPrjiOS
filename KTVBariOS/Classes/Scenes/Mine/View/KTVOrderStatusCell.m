
//
//  KTVOrderStatusCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/11.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderStatusCell.h"

@interface KTVOrderStatusCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeBuyLabel; // 酒吧卡座预定
@property (weak, nonatomic) IBOutlet UILabel *activitersLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yudingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiadanLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;


@end

@implementation KTVOrderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (IBAction)orderCancelAction:(UIButton *)sender {
    CLog(@"-->> 取消订单");
}


@end
