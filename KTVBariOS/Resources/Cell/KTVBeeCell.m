//
//  KTVBeeCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBeeCell.h"

@interface KTVBeeCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageview;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;


@end

@implementation KTVBeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headImageview.layer.cornerRadius = CGRectGetWidth(self.headImageview.frame) / 2;
}

- (void)setUser:(KTVUser *)user {
    KTVPicture *pic = user.pictureList.firstObject;
    [self.headImageview sd_setImageWithURL:[NSURL URLWithString:pic.pictureUrl]
                          placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
    self.nickLabel.text = user.nickName;
    self.genderImageView.image = user.sex ? [UIImage imageNamed:@"app_user_man"] : [UIImage imageNamed:@"app_user_woman"];
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁", @(user.age)];
    self.activityLabel.text = user.userDetail.todayMood;
}

- (void)setNearUser:(KTVNearUser *)nearUser {
    if (_nearUser != nearUser) {
        _nearUser = nearUser;
        
        [self setUser:nearUser.userModel];
        self.addressLabel.text = [NSString stringWithFormat:@"%@米以内", nearUser.distance];
    }
}

- (IBAction)enterStoreAction:(id)sender {
    CLog(@"-->> 进店查看");
    if (self.enterStoreCallback) self.enterStoreCallback(self.nearUser);
}
@end
