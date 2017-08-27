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


- (IBAction)buyAction:(UIButton *)sender {
    CLog(@"--->>> 点击购物车");
    [sender setSelected:!sender.isSelected];
    
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"buy_car_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"buy_car_purple"] forState:UIControlStateNormal];
    }
}

@end
