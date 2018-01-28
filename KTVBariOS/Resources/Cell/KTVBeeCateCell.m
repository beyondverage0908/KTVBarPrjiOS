//
//  KTVBeeCateCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBeeCateCell.h"

@interface KTVBeeCateCell()

@property (weak, nonatomic) IBOutlet UIImageView *beeHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation KTVBeeCateCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)invitateAction:(UIButton *)sender {
    CLog(@"-->> 约他");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    
    @WeakObj(self);
    if (self.callback) {
        weakself.callback(weakself.user,sender.isSelected);
    }
}

- (void)setUser:(KTVUser *)user {
    if (_user != user) {
        _user = user;
        
        [self.beeHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_user.pictureList.firstObject.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
        self.nicknameLabel.text = _user.nickName;
        self.addressLabel.text = [NSString stringWithFormat:@"500米以内"];
        NSString *genderUrl = _user.sex ? @"app_user_man" : @"app_user_woman";
        self.genderImageView.image = [UIImage imageNamed:genderUrl];
        self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(_user.age)];
        self.descriLabel.text = _user.userDetail.todayMood;
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/场", @(_user.userDetail.price)];
    }
}

@end
