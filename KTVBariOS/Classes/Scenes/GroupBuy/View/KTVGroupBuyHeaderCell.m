//
//  KTVGroupBuyHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/21.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVGroupBuyHeaderCell.h"

@interface KTVGroupBuyHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *detailInstrLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuepaoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


@end

@implementation KTVGroupBuyHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)buyAction:(UIButton *)sender {
    CLog(@"--->>>团购详情-立即购买");
}
@end
