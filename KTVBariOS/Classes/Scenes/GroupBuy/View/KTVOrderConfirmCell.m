//
//  KTVOrderConfirmCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderConfirmCell.h"

@interface KTVOrderConfirmCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation KTVOrderConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPackageList:(NSArray<KTVPackage *> *)packageList {
    _packageList = packageList;
    
    KTVPackage *package = [_packageList firstObject];
    self.nameLabel.text = package.packageName;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
}

- (void)setSelectedActivitorList:(NSArray<KTVUser *> *)selectedActivitorList {
    _selectedActivitorList = selectedActivitorList;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [self getOrderMoney]];
}

/// 获取当前选择套餐和暖场人的总价
- (NSString *)getOrderMoney {
    float price = 0;
    // 套餐价格
    for (KTVPackage *pk in self.packageList) {
        price += pk.price.floatValue;
    }
    // 暖场人价格
    for (KTVUser *user in self.selectedActivitorList) {
        price += user.userDetail.price;
    }
    return @(price).stringValue;
}

@end
