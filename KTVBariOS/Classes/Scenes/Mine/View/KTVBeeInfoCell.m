//
//  KTVBeeInfoCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/10/31.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBeeInfoCell.h"

@interface KTVBeeInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;  // 是否单身
@property (weak, nonatomic) IBOutlet UILabel *desLabel; // 我有故事，你有酒
@property (weak, nonatomic) IBOutlet UILabel *moodLabel; // 心情
@property (weak, nonatomic) IBOutlet UILabel *hobbyLabel;
@property (weak, nonatomic) IBOutlet UILabel *vedioAuthenticateLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeVedioBtn;

@end

@implementation KTVBeeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)toSeeVedio:(id)sender {
    CLog(@"-->>> 查看认证视频");
}

- (void)setUser:(KTVUser *)user {
    if (_user != user) {
        _user = user;
        
        self.addressLabel.text = @"南京东路";
        self.statusLabel.text = @"单身";
        self.desLabel.text = @"我有故事，你有酒";
        self.moodLabel.text = @"我很高心";
        self.hobbyLabel.text = @"打球，唱吧";
        self.vedioAuthenticateLabel.text = @"视频已经认证";
    }
}
@end
