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

@end
