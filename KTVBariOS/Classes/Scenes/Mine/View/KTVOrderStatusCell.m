
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
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;


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
    // 已支付，未响应，未使用，已响应 --- 需要退款
    if (self.orderCancelCallBack) {
        BOOL isRefunded = YES;
        if (_order.orderStatus == -1) {
            isRefunded = NO;
        }
        self.orderCancelCallBack(self.order.orderId, self.order.orderType, isRefunded);
    }
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
    if (self.order.des && self.order.des.length) {
        self.storeBuyLabel.text = self.order.des;
    } else {
        self.storeBuyLabel.text = @"基础订单";
    }
    
//    orderStatus;//99:全部 -1:未支付，0,已支付, 1未响应，2未使用，3被商家忽略，4已响应，5待评论，，6已取消，7已结束
    NSString *orderText = [self orderStatusTextWithOrderStatus:_order.orderStatus andOrderType:_order.orderType];
    if (_order.orderStatus == 3 || _order.orderStatus == 5 || _order.orderStatus == 6 || _order.orderStatus == 7) {
        self.cancelOrderBtn.hidden = YES;
    }
    self.orderStatusLabel.text = orderText;

    /// 1套餐，2酒吧位置价格 3包厢类型的价格 ,4暖场人，5 单点商品的价格如果是单点商品，会出现数量为2的情况），6普通邀约人（这个单价为0）7 团购 8 活动
    self.orderTypeLabel.text = [self orderTypeTextWithOrderType:_order.orderType];
}

- (NSString *)orderTypeTextWithOrderType:(NSInteger)type {
    NSString *orderTypeText = @"";
    if (_order.orderType == 1) {
        orderTypeText = @"套餐订单";
    } else if (_order.orderType == 2) {
        orderTypeText = @"酒吧位置订单";
    } else if (_order.orderType == 3) {
        orderTypeText = @"包厢订单";
    } else if (_order.orderType == 4) {
        orderTypeText = @"暖场人订单";
    } else if (_order.orderType == 5) {
        orderTypeText = @"单点商品订单";
    } else if (_order.orderType == 6) {
        orderTypeText = @"普通邀约人订单";
    } else if (_order.orderType == 7) {
        orderTypeText = @"团购订单";
    } else if (_order.orderType == 8) {
        orderTypeText = @"活动订单";
    }
    return orderTypeText;
}

- (NSString *)orderStatusTextWithOrderStatus:(NSInteger)status andOrderType:(NSInteger)orderType {
    NSString *statusText = @"";
    if (status == -1) {
        statusText = @"未支付";
    } else if (status == 0) {
        statusText = @"已支付";
    } else if (status == 1) {
        if (orderType != 4) {
            statusText = @"等待TA响应";
        } else {
            statusText = @"等待商家响应";
        }
    } else if (status == 2) {
        statusText = @"未使用";
    } else if (status == 3) {
        statusText = @"已被商家忽略";
    } else if (status == 4) {
        statusText = @"已响应";
    } else if (status == 5) {
        statusText = @"待评论";
    } else if (status == 6) {
        statusText = @"已取消";
    } else if (status == 7) {
        statusText = @"已结束";
    }
    return statusText;
}

@end
