//
//  KTVPayMoneyCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVPayMoneyCell.h"

@interface KTVPayMoneyCell()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation KTVPayMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)payMoneyAction:(UIButton *)sender {
    CLog(@"-->> 付款");
    @WeakObj(self);
    if (self.payMoneyAction) {
        self.payMoneyAction(weakself.money);
    }
}

@end
