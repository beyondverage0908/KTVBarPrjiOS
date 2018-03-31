//
//  KTVInvitatingCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVInvitatingCell.h"

@interface KTVInvitatingCell()

@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *leftTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end

@implementation KTVInvitatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)refuseAction:(id)sender {
    CLog(@"-->> 拒绝");
    if (self.denyCallback) self.denyCallback(self.warmerOrder);
}

- (IBAction)acceptAction:(id)sender {
    CLog(@"-->> 接受");
    if (self.agreeCallback) self.agreeCallback(self.warmerOrder);
}

- (void)setWarmerOrder:(KTVWarmerOrder *)warmerOrder {
    if (_warmerOrder != warmerOrder) {
        _warmerOrder = warmerOrder;
        // UI赋值
        self.storeName.text = _warmerOrder.storeName;
        self.leftTime.text = @"";
        self.location.text = [NSString stringWithFormat:@"北京东路 3km"];
        self.time.text = _warmerOrder.createTime;
        self.price.text = [NSString stringWithFormat:@"%@¥/场", _warmerOrder.price];
    }
}

@end
