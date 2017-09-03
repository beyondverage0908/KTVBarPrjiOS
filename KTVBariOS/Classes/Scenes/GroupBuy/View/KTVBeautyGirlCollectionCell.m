//
//  KTVBeautyGirlCollectionCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/30.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBeautyGirlCollectionCell.h"

@interface KTVBeautyGirlCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *beautyHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuetaLabel;
@property (weak, nonatomic) IBOutlet UIButton *yuetaBtn;

@end

@implementation KTVBeautyGirlCollectionCell

- (IBAction)yuetaAction:(UIButton *)sender {
    CLog(@"--->>> 约她");
    [sender setSelected:!sender.isSelected];
    
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_kuang_red"] forState:UIControlStateNormal];
    }
}


@end
