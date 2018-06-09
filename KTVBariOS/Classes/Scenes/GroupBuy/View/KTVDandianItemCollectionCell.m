//
//  KTVDandianItemCollectionCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/27.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDandianItemCollectionCell.h"

@interface KTVDandianItemCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation KTVDandianItemCollectionCell

- (void)setGood:(KTVGood *)good {
    if (_good != good) {
        _good = good;
        
        [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:_good.picture.pictureUrl] placeholderImage:[UIImage imageNamed:@"dianpu_dandian_single"]];
        self.nameLabel.text = _good.goodName;
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", _good.goodPrice];
        self.buyNumberLabel.hidden = YES;
    }
}


- (IBAction)buyAction:(UIButton *)sender {
    CLog(@"--->>> 点击购物车");
    [sender setSelected:!sender.isSelected];
    
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"buy_car_red"] forState:UIControlStateNormal];
        if (self.buyCarCallBack) {
            self.buyCarCallBack(YES, self.good);
        }
    } else {
        [sender setImage:[UIImage imageNamed:@"buy_car_purple"] forState:UIControlStateNormal];
        if (self.buyCarCallBack) {
            self.buyCarCallBack(NO, self.good);
        }
    }
}

@end
