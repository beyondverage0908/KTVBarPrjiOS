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
    
    self.user.isSelected = sender.isSelected;
    
    if (self.callback) {
        self.callback(self.user);
    }
}

- (void)setUser:(KTVUser *)user {
    _user = user;
    
    [self.yuetaBtn setSelected:NO];
    
    [self.yuetaBtn setImage:[UIImage imageNamed:@"app_kuang_red"] forState:UIControlStateNormal];
    self.nicknameLabel.text = user.nickName;
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(user.age)];
    if (user.sex == 0) {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_woman"] forState:UIControlStateNormal];
    } else {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_man"] forState:UIControlStateNormal];
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%@/场", @(_user.userDetail.price)];
    
    if (_user.isSelected) {
        [self.yuetaBtn setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [self.yuetaBtn setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    
    [self.beautyHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_user.pictureList.firstObject.pictureUrl] placeholderImage:[UIImage imageNamed:@"dianpu_dandian_single"]];
}


@end
