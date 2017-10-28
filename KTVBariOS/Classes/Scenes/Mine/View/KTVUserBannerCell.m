//
//  KTVUserBannerCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserBannerCell.h"

@interface KTVUserBannerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *purikuraImgView; // 大头贴
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIView *tipsView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;

@end

@implementation KTVUserBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImgView.layer.cornerRadius = self.headerImgView.frame.size.width / 2;
    self.headerImgView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yueAction:)];
    [self.yueLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUser:(KTVUser *)user {
    _user = user;
    
    if (_user) {
        if (_user.pictureList.count >= 1) {
            KTVPicture *headerPic = _user.pictureList.firstObject;
            [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:headerPic.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_yuepao_user_placeholder"]];
        }
        if (_user.pictureList.count >= 2) {
            KTVPicture *heardBgPic = _user.pictureList[1];
            [self.purikuraImgView sd_setImageWithURL:[NSURL URLWithString:heardBgPic.pictureUrl] placeholderImage:[UIImage imageNamed:@"mine_header_placeholder"]];
        }
        
        self.nicknameLabel.text = _user.username;
        
        NSString *age = @(_user.age).stringValue;
        UILabel *ageLabel = [[UILabel alloc] init];
        ageLabel.text = [NSString stringWithFormat:@"%@岁", age];
        ageLabel.backgroundColor = [UIColor ktvRed];
        ageLabel.font = [UIFont bold13];
        ageLabel.textColor = [UIColor whiteColor];
        [self.tipsView addSubview:ageLabel];
        [ageLabel sizeToFit];
        ageLabel.layer.cornerRadius = 3;
        ageLabel.layer.masksToBounds = YES;
        ageLabel.frame = CGRectMake(0, 5, CGRectGetWidth(ageLabel.frame), CGRectGetHeight(ageLabel.frame));
        
        NSString *constellation = _user.userDetail.constellation;
        UILabel *constellationLabel = [[UILabel alloc] init];
        constellationLabel.text = [NSString stringWithFormat:@"%@", constellation];
        constellationLabel.backgroundColor = [UIColor ktvRed];
        constellationLabel.font = [UIFont bold13];
        constellationLabel.textColor = [UIColor whiteColor];
        [self.tipsView addSubview:constellationLabel];
        [constellationLabel sizeToFit];
        constellationLabel.layer.cornerRadius = 3;
        constellationLabel.layer.masksToBounds = YES;
        constellationLabel.frame = CGRectMake(CGRectGetMaxX(ageLabel.frame) + 20, CGRectGetMinY(ageLabel.frame), CGRectGetWidth(constellationLabel.frame), CGRectGetHeight(constellationLabel.frame));
        //
        //    NSString *hobby = _user.userDetail.hobby;
        //    UILabel *hobbyLabel = [[UILabel alloc] init];
        //    hobbyLabel.text = [NSString stringWithFormat:@"%@", hobby];
        //    hobbyLabel.backgroundColor = [UIColor ktvRed];
        //    hobbyLabel.font = [UIFont bold13];
        //    hobbyLabel.textColor = [UIColor whiteColor];
        //    [self.tipsView addSubview:hobbyLabel];
        //    [hobbyLabel sizeToFit];
        //    hobbyLabel.layer.cornerRadius = 3;
        //    hobbyLabel.layer.masksToBounds = YES;
        //    hobbyLabel.frame = CGRectMake(CGRectGetMaxX(constellationLabel.frame) + 20, CGRectGetMinY(constellationLabel.frame), CGRectGetWidth(hobbyLabel.frame), CGRectGetHeight(hobbyLabel.frame));
    }
}

- (void)setIsSelf:(BOOL)isSelf {
    if (isSelf) {
        self.addFriendBtn.hidden = YES;
    }
}

#pragma mark - 事件

- (void)yueAction:(UILabel *)sender {
    CLog(@"-- TA正在拼桌，点击查看");
}

- (IBAction)addFriendAction:(UIButton *)sender {
    CLog(@"-- 添加好友");
}
@end
