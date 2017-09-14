//
//  KTVYuePaoUserCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVYuePaoUserCell.h"

@interface KTVYuePaoUserCell ()

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLoveLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuetaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImage;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;


@end

@implementation KTVYuePaoUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)yuetaAction:(UIButton *)sender {
    CLog(@"--->>>约她");
    [sender setSelected:!sender.isSelected];
    
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    
    if (self.yueCallback) {
        self.yueCallback(self.user, sender.isSelected);
    }
}

- (void)setUser:(KTVUser *)user {
    _user = user;
    
    self.nicknameLabel.text = _user.nickName;
    if (user.sex == 1) {
        self.genderImage.image = [UIImage imageNamed:@"app_user_man"];
    } else {
        self.genderImage.image = [UIImage imageNamed:@"app_user_woman"];
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(_user.age)];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@/场", _user.money];
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_user.userDetail.headerUrl]
                                placeholderImage:ktvUserHeaderDefaultImg];
}

@end
