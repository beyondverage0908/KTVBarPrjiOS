//
//  KTVPZUserHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPZUserHeaderCell.h"

@interface KTVPZUserHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@end

@implementation KTVPZUserHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUser:(KTVUser *)user {
    _user = user;
    
    self.nicknameLabel.text = user.username;
    if (user.sex) {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_man"] forState:UIControlStateNormal];
    } else {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_woman"] forState:UIControlStateNormal];
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(user.age)];
}

@end
