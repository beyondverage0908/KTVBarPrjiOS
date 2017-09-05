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

@end

@implementation KTVUserBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yueAction:)];
    [self.yueLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (void)yueAction:(UILabel *)sender {
    CLog(@"-- TA正在拼桌，点击查看");
}

- (IBAction)addFriendAction:(UIButton *)sender {
    CLog(@"-- 添加好友");
}
@end
