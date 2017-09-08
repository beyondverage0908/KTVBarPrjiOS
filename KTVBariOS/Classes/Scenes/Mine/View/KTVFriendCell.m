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

@end

@implementation KTVFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];

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

- (IBAction)btnAction:(UIButton *)sender {
    if (_friendType == FriendChatType) {
        CLog(@"-->> 聊天");
    } else if (_friendType == FriendAddType) {
        CLog(@"-->> 添加好友");
    }
}
@end
