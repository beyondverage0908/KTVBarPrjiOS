//
//  KTVInvitationAcceptCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVInvitationAcceptCell.h"

@interface KTVInvitationAcceptCell()

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end

@implementation KTVInvitationAcceptCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setWarmerOrder:(KTVWarmerOrder *)warmerOrder {
    if (_warmerOrder != warmerOrder) {
        _warmerOrder = warmerOrder;
        // UI赋值
        self.storeName.text = _warmerOrder.storeName;
        self.location.text = [NSString stringWithFormat:@"北京东路 3km"];
        self.time.text = _warmerOrder.createTime;
        self.price.text = [NSString stringWithFormat:@"%@¥/场", _warmerOrder.price];
    }
}

@end
