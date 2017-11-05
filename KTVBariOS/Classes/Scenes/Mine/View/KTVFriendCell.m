//
//  KTVFriendCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/7.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVFriendCell.h"

@interface KTVFriendCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *funcBtn; // 更具类型区分按钮的功能，和图片的现实
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteStatusLabel;

@end

@implementation KTVFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.statusLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusTapAction:)];
    [self.statusLabel addGestureRecognizer:tap];
    
    [self.headerImageView cornerRadius];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setFriendType:(FriendType)friendType {
    _friendType = friendType;
    
    if (_friendType == FriendChatType) {
        [self.funcBtn setImage:[UIImage imageNamed:@"app_chat"] forState:UIControlStateNormal];
    } else if (_friendType == FriendAddType) {
        [self.funcBtn setImage:[UIImage imageNamed:@"app_add_friend"] forState:UIControlStateNormal];
    }
}

- (void)setUser:(KTVUser *)user {
    _user = user;
    
    self.nicknameLabel.text = _user.nickName ? _user.nickName : _user.username;
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(_user.age)];
    self.tipLabel.text = _user.userDetail.todayMood;
    if (_user.inviteStatus == 2) {
        self.inviteStatusLabel.text = @"我买单";
        self.inviteStatusLabel.textColor = [UIColor ktvGold];
    } else if (_user.inviteStatus == 1) {
        self.inviteStatusLabel.text = @"AA制";
        self.inviteStatusLabel.textColor = [UIColor ktvGold];
    }
    
    if (_user.shareTableStatus == 1) {
        self.statusLabel.text = @"正在拼桌点击查看";
        self.statusLabel.textColor = [UIColor ktvRed];
        [self.statusLabel addUnderlineStyle];
    } else {
        self.statusLabel.text = @"";
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    if (_friendType == FriendChatType) {
        CLog(@"-->> 聊天");
    } else if (_friendType == FriendAddType) {
        CLog(@"-->> 添加好友");
    }
}

- (void)statusTapAction:(UITapGestureRecognizer *)tap {
    CLog(@"-->> 他正在拼桌");
    if (self.pinzuoCallback) {
        self.pinzuoCallback(self.user);
    }
}

@end
