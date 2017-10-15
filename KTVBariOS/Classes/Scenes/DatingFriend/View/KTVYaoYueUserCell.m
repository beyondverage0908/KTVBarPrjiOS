//
//  KTVYaoYueUserCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVYaoYueUserCell.h"

@interface KTVYaoYueUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; // 当前在约的状态
@property (weak, nonatomic) IBOutlet UILabel *tipLabel; // 用户宣言

@end

@implementation KTVYaoYueUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.statusLabel addUnderlineStyle];
    
    self.statusLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinZhuoAction:)];
    [self.statusLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setInviteUser:(KTVInvitedUser *)inviteUser {
    _inviteUser = inviteUser;
    
    self.nicknameLabel.text = _inviteUser.user.nickName;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@米以内", _inviteUser.distance];
    if (_inviteUser.user.sex) {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_man"] forState:UIControlStateNormal];
    } else {
        [self.genderBtn setImage:[UIImage imageNamed:@"app_user_woman"] forState:UIControlStateNormal];
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(_inviteUser.user.age)];
    if (_inviteUser.user.shareTableStatus == 1) {
        self.statusLabel.text = @"TA正在拼桌，点击查看";
    }
    if (_inviteUser.user.inviteStatus == 1) {
        
    }
}

- (IBAction)yueTaAction:(UIButton *)sender {
    CLog(@"-- 约TA");
    
    if (self.yueTaCallback) {
        self.yueTaCallback(self.inviteUser);
    }
}

- (void)pinZhuoAction:(UITapGestureRecognizer *)tap {
    CLog(@"查看拼桌详情...");
    if (self.pinzhuoCallback) {
        self.pinzhuoCallback(self.inviteUser);
    }
}

@end
