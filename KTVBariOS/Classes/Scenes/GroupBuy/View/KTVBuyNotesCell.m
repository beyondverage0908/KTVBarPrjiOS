//
//  KTVBuyNotesCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/22.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBuyNotesCell.h"

@interface KTVBuyNotesCell ()

@property (weak, nonatomic) IBOutlet UILabel *buyValidtime; // 有效期
@property (weak, nonatomic) IBOutlet UILabel *buyRuleLabel; // 规则提醒
@property (weak, nonatomic) IBOutlet UILabel *buynotesLabel; // 温馨提示

@end

@implementation KTVBuyNotesCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 设置

- (void)setStore:(KTVStore *)store {
    _store = store;
}

- (void)setGroupbuy:(KTVGroupbuy *)groupbuy {
    _groupbuy = groupbuy;
    
    self.buyValidtime.text = _groupbuy.buyNotice;
    self.buyRuleLabel.text = _groupbuy.remark;
    self.buynotesLabel.text = _groupbuy.notice;
}

- (void)setPackage:(KTVPackage *)package {
    _package = package;
    
    self.buyValidtime.text = _package.buyTime;
    self.buyRuleLabel.text = _package.belong;
    self.buynotesLabel.text = _package.notice;
}

@end
