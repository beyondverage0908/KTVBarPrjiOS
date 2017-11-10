//
//  KTVUserHeaderCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserHeaderCell.h"

@interface KTVUserHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@end

@implementation KTVUserHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImageView.layer.cornerRadius = CGRectGetWidth(self.headerImageView.frame) / 2.0f;
    self.headerImageView.layer.masksToBounds = YES;
}


- (IBAction)modifyUserInfoAction:(UIButton *)sender {
    CLog(@"-- 查看修改个人信息");
    if ([self.delegate respondsToSelector:@selector(toseeMineInfo:)]) {
        [self.delegate toseeMineInfo:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)loginStateAction:(UIButton *)sender {
    CLog(@"--->> 登陆");
    
    if ([self.delegate respondsToSelector:@selector(gotoLogin)]) {
        [self.delegate gotoLogin];
    }
}

#pragma mark - 设置

- (void)setUser:(KTVUser *)user {
    if (_user != user) {
        _user = user;
        
        if (_user) {
            self.loginTypeBtn.hidden = YES;
        } else {
            self.loginTypeBtn.hidden = NO;
        }
        
        self.nicknameLabel.text = _user.nickName ? _user.nickName : _user.username;
    
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_user.pictureList.firstObject.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
        if (_user.pictureList.count > 2) {
            [self.headerBgImageView sd_setImageWithURL:[NSURL URLWithString:_user.pictureList[1].pictureUrl] placeholderImage:[UIImage imageNamed:@"mine_header_placeholder"]];
        }
    }
}


@end
