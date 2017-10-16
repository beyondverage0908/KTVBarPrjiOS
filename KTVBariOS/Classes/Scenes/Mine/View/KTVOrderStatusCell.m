
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

- (void)setOrder:(KTVOrder *)order {
    _order = order;
    
    self.orderIdLabel.text = _order.subOrderId;
    self.storeNameLabel.text = _order.store.storeName;
    self.activitersLabel.text = _order.user.username;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", _order.allMoney];
    self.yudingTimeLabel.text = _order.createTime;
    self.xiadanLabel.text = _order.startTime;
    self.mobileLabel.text = _order.user.phone;
    
//    orderStatus;//99:全部 -1:未支付，0,已支付, 1未响应，2未使用，3被商家忽略，4已响应，5待评论，，6已取消，7已结束
    if (_order.orderStatus == -1) {
        self.orderStatusLabel.text = @"未支付";
    } else if (_order.orderStatus == 0) {
        self.orderStatusLabel.text = @"已支付";
    } else if (_order.orderStatus == 1) {
        self.orderStatusLabel.text = @"未响应";
    } else if (_order.orderStatus == 2) {
        self.orderStatusLabel.text = @"未使用";
    } else if (_order.orderStatus == 3) {
        self.orderStatusLabel.text = @"被商家忽略";
    } else if (_order.orderStatus == 4) {
        self.orderStatusLabel.text = @"已响应";
    } else if (_order.orderStatus == 5) {
        self.orderStatusLabel.text = @"待评论";
    } else if (_order.orderStatus == 6) {
        self.orderStatusLabel.text = @"已取消";
    } else if (_order.orderStatus == 7) {
        self.orderStatusLabel.text = @"已结束";
    }
}

@end
